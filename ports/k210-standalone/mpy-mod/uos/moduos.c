/*
 * This file is part of the MicroPython project, http://micropython.org/
 *
 * Development of the code in this file was sponsored by Microbric Pty Ltd
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2015 Josef Gajdusek
 * Copyright (c) 2016 Damien P. George
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <string.h>

#include "py/objtuple.h"
#include "py/objstr.h"
#include "py/runtime.h"
#include "py/mperrno.h"
#include "py/mphal.h"
#include "extmod/misc.h"
#if MICROPY_VFS
#include "extmod/vfs.h"
#include "extmod/vfs_fat.h"
#endif
#include "genhdr/mpversion.h"
#if !MICROPY_VFS
#include "spiffs-port.h"
#include "py/lexer.h"
#endif

extern mp_obj_t file_open(const char* file_name, const mp_obj_type_t *type, mp_arg_val_t *args);
extern const mp_obj_type_t mp_type_vfs_spiffs_textio;
char current_dir[SPIFFS_OBJ_NAME_LEN + 1] = { "/" }; // default dir
char *API_FS_FullPath(const char *path);
extern const mp_obj_type_t mp_fat_vfs_type;
extern uint32_t yasmarang(void);

STATIC const qstr os_uname_info_fields[] = {
    MP_QSTR_sysname, MP_QSTR_nodename,
    MP_QSTR_release, MP_QSTR_version, MP_QSTR_machine
};
STATIC const MP_DEFINE_STR_OBJ(os_uname_info_sysname_obj, MICROPY_PY_SYS_PLATFORM);
STATIC const MP_DEFINE_STR_OBJ(os_uname_info_nodename_obj, MICROPY_PY_SYS_PLATFORM);
STATIC const MP_DEFINE_STR_OBJ(os_uname_info_release_obj, MICROPY_VERSION_STRING);
STATIC const MP_DEFINE_STR_OBJ(os_uname_info_version_obj, MICROPY_GIT_TAG " on " MICROPY_BUILD_DATE);
STATIC const MP_DEFINE_STR_OBJ(os_uname_info_machine_obj, MICROPY_HW_BOARD_NAME " with " MICROPY_HW_MCU_NAME);

STATIC MP_DEFINE_ATTRTUPLE(
    os_uname_info_obj,
    os_uname_info_fields,
    5,
    (mp_obj_t)&os_uname_info_sysname_obj,
    (mp_obj_t)&os_uname_info_nodename_obj,
    (mp_obj_t)&os_uname_info_release_obj,
    (mp_obj_t)&os_uname_info_version_obj,
    (mp_obj_t)&os_uname_info_machine_obj
);

STATIC mp_obj_t os_uname(void) {
    return (mp_obj_t)&os_uname_info_obj;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_0(os_uname_obj, os_uname);

STATIC mp_obj_t os_urandom(mp_obj_t num) {
    mp_int_t n = mp_obj_get_int(num);
    vstr_t vstr;
    vstr_init_len(&vstr, n);
    uint32_t r = 0;
    for (int i = 0; i < n; i++) {
        if ((i & 3) == 0) {
#if MICROPY_PY_URANDOM        
            r = yasmarang(); // returns 32-bit hardware random number
#endif
        }
        vstr.buf[i] = r;
        r >>= 8;
    }
    return mp_obj_new_str_from_vstr(&mp_type_bytes, &vstr);
}
STATIC MP_DEFINE_CONST_FUN_OBJ_1(os_urandom_obj, os_urandom);

mp_import_stat_t mp_vfs_import_stat(const char *path) {
    int32_t fd;
    char temp_obj_path[SPIFFS_OBJ_NAME_LEN + 2];

    if (path[0] == '/') {
        strcpy(temp_obj_path, path);
    } else {
        strcpy(temp_obj_path, "/");
        strcat(temp_obj_path, path);
    }
    fd = SPIFFS_open(&fs, temp_obj_path, SPIFFS_O_RDONLY, 0);
    if(fd > 0) {
        SPIFFS_close(&fs, fd);
        return MP_IMPORT_STAT_FILE;
    } else {
        return MP_IMPORT_STAT_NO_EXIST;
    }
}

#if MICROPY_PY_OS_DUPTERM
STATIC mp_obj_t os_dupterm_notify(mp_obj_t obj_in) {
    (void)obj_in;
    for (;;) {
        int c = mp_uos_dupterm_rx_chr();
        if (c < 0) {
            break;
        }
        ringbuf_put(&stdin_ringbuf, c);
    }
    return mp_const_none;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_1(os_dupterm_notify_obj, os_dupterm_notify);
#endif

#if !MICROPY_VFS

char *API_FS_GetCurDir()
{
    return current_dir;
}

void API_FS_InitDir()
{
    strcpy(current_dir, "/");
}
 
void API_FS_ChangeDir(const char *path)
{
    if (path[0] == '/') {
        strncpy(current_dir, path, SPIFFS_OBJ_NAME_LEN - 1);
    } else {
        strncat(current_dir, path, SPIFFS_OBJ_NAME_LEN - strlen(current_dir) - 1);
    }
    current_dir[SPIFFS_OBJ_NAME_LEN] = '\0'; // stop sign at the end
    // append '/' if it is missing
    int len = strlen(current_dir);
    if (len < 1 || current_dir[len - 1] != '/') {
        current_dir[len] = '/';
        current_dir[len + 1] = '\0';
    }
}

char* API_FS_FullPath(const char *path_in)
{
    char *path = malloc(strlen(current_dir) + strlen(path_in) + 2);
    if (path != NULL) {
        if (path_in[0] != '/') { // prefix current_dir
            strcpy(path, current_dir);
            strcat(path, path_in);
        } else {
            strcpy(path, path_in);
        }
    }
    return path;
}

mp_obj_t mp_vfs_ls(size_t n_args, const mp_obj_t *args) {
    mp_obj_t dir_list = mp_obj_new_list(0, NULL);
    char* dirToList = "";

    if(n_args != 0 ) {
        dirToList = (char*)mp_obj_str_get_str(args[0]);
    } 
    if (n_args == 0 || strcmp(dirToList, ".") == 0) {
        dirToList = API_FS_GetCurDir();
    }
    spiffs_DIR dir;
    if (!SPIFFS_opendir (&fs, (const char*)dirToList, &dir)) {
        mp_raise_OSError(MP_EIO);
    }
    struct spiffs_dirent de;
    while (SPIFFS_readdir (&dir, &de)) {
        static const char types[] = "?fdhs"; // file, dir, hardlink, softlink
        char name[sizeof(de.name) + 1] = { 0 };
        memcpy (name, de.name, sizeof(de.name));
        // match the start of the name with current_dir
        if (strncmp(name, dirToList, strlen(dirToList)) == 0) {
            char res_str[SPIFFS_OBJ_NAME_LEN + 10] = {0};
            sprintf(res_str,"%c %6u %s", types[de.type], de.size, name);

            // Trace(1,"dir name:%s",dirent->d_name);
            mp_obj_t dirStr = mp_obj_new_str(res_str,strlen(res_str));
            mp_obj_list_append(dir_list, dirStr);
        }
    }
    SPIFFS_closedir (&dir);
    SPIFFS_opendir(&fs, API_FS_GetCurDir(), &dir);
    return dir_list;
}
MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(mp_vfs_ls_obj, 0, 1, mp_vfs_ls);

mp_obj_t mp_vfs_listdir(size_t n_args, const mp_obj_t *args) {
    mp_obj_t dir_list = mp_obj_new_list(0, NULL);
    char *dirToList ="";

    if(n_args != 0 ) {
        dirToList = (char*)mp_obj_str_get_str(args[0]);
    } 
    if (n_args == 0 || strcmp(dirToList, ".") == 0) {
        dirToList = API_FS_GetCurDir();
    }
    spiffs_DIR dir;
    if (!SPIFFS_opendir (&fs, (const char*)dirToList, &dir)) {
        mp_raise_OSError(MP_EIO);
    }
    struct spiffs_dirent de;
    while (SPIFFS_readdir (&dir, &de)) {
        char name[SPIFFS_OBJ_NAME_LEN] = { 0 };
        memcpy (name, de.name, strlen((char *)(de.name)));
        // match the start of the name with current_dir
        if (strncmp(name, dirToList, strlen(dirToList)) == 0) {
            char res_str[SPIFFS_OBJ_NAME_LEN + 1] = {0};
            sprintf(res_str,"%s",name);
            // Trace(1,"dir name:%s",dirent->d_name);
            mp_obj_t dirStr = mp_obj_new_str(res_str, strlen(res_str));
            mp_obj_list_append(dir_list, dirStr);
        }
    }
    SPIFFS_closedir (&dir);
    SPIFFS_opendir(&fs, API_FS_GetCurDir(), &dir);
    return dir_list;
}
MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(mp_vfs_listdir_obj, 0, 1, mp_vfs_listdir);

mp_obj_t mp_vfs_formatfs(size_t n_args, const mp_obj_t *args) {

    int res = format_fs();
    printf("[MAIXPY]SPIFFS:mount %s \n", res?"failed":"successful");
    return mp_const_none;
}
MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(mp_vfs_formatfs_obj, 0, 1, mp_vfs_formatfs);


mp_obj_t mp_vfs_mkdir(mp_obj_t path_in) {
    return mp_const_none;
}
MP_DEFINE_CONST_FUN_OBJ_1(mp_vfs_mkdir_obj, mp_vfs_mkdir);


mp_obj_t mp_vfs_remove(mp_obj_t path_in) {
    char* path = API_FS_FullPath(mp_obj_str_get_str(path_in));

    if(strcmp(path,"/") == 0 || strcmp(path,"/t") == 0) {
        mp_raise_OSError(MP_EINVAL);
    }
    s32_t ret = SPIFFS_remove(&fs,path);
    free(path);
    if(ret != 0) {
        mp_raise_OSError(MP_EIO);
    }
    return mp_const_none;
}
MP_DEFINE_CONST_FUN_OBJ_1(mp_vfs_remove_obj, mp_vfs_remove);

mp_obj_t mp_vfs_rename(mp_obj_t old_path_in, mp_obj_t new_path_in) {
    char* path_old = API_FS_FullPath(mp_obj_str_get_str(old_path_in));
    char* path_new = API_FS_FullPath(mp_obj_str_get_str(new_path_in));

    s32_t ret = SPIFFS_rename(&fs, path_old, path_new);
    free(path_old);
    free(path_new);
    if(ret != 0) {
        mp_raise_OSError(MP_EIO);
    }
    return mp_const_none;
}
MP_DEFINE_CONST_FUN_OBJ_2(mp_vfs_rename_obj, mp_vfs_rename);

//#define SPIFFS_SEEK_SET                 (0)
//#define SPIFFS_SEEK_CUR                 (1)
//#define SPIFFS_SEEK_END                 (2)

mp_obj_t mp_vfs_write(size_t n_args, const mp_obj_t *args) {

    const char* path = mp_obj_str_get_str(args[0]);
    s32_t offset = mp_obj_get_int(args[1]);
    int mode = mp_obj_get_int(args[2]);
    mp_buffer_info_t bufinfo;
    mp_get_buffer_raise(args[3], &bufinfo, MP_BUFFER_READ);
    spiffs_file fd;
    fd=SPIFFS_open(&fs,path, SPIFFS_CREAT | SPIFFS_TRUNC | SPIFFS_RDWR, 0);
    if(fd == -1) {
        mp_raise_OSError(MP_EIO);
    }
    s32_t ls_res = SPIFFS_lseek(&fs, fd,offset,mode);
    if(ls_res != 0){
        printf("[MAIXPY]FS:Lseek err\n");
        mp_raise_OSError(MP_EIO);
    }
    s32_t w_res = SPIFFS_write(&fs, fd, bufinfo.buf, bufinfo.len);
    if(w_res <= 0){
        printf("[MAIXPY]FS:Write err\n");
        mp_raise_OSError(MP_EIO);
    }
    s32_t f_res = SPIFFS_fflush(&fs, fd);
    if(f_res != 0){
        printf("[MAIXPY]FS:Fflush err\n");
        mp_raise_OSError(MP_EIO);
    }
    SPIFFS_close (&fs, fd);
    return mp_const_none;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(mp_vfs_write_obj, 4, 4, mp_vfs_write);

mp_obj_t mp_vfs_read(size_t n_args, const mp_obj_t *args) {

    const char* path = mp_obj_str_get_str(args[0]);
    s32_t offset = mp_obj_get_int(args[1]);
    int mode = mp_obj_get_int(args[2]);
    mp_buffer_info_t bufinfo;
    mp_get_buffer_raise(args[3], &bufinfo, MP_BUFFER_WRITE);
    spiffs_file fd;
    fd = SPIFFS_open(&fs, path, SPIFFS_RDWR, 0);
    if(fd == -1){
        mp_raise_OSError(MP_EIO);
    }

    s32_t ls_res = SPIFFS_lseek(&fs, fd, offset, mode);
    if(ls_res != 0) {
        mp_raise_OSError(MP_EIO);
    }
    s32_t r_res = SPIFFS_read(&fs, fd, bufinfo.buf, bufinfo.len);
    if(r_res <  0){
        printf("[MAIXPY]FS:read err %d\n",r_res);
        mp_raise_OSError(MP_EIO);
    }
    SPIFFS_close (&fs, fd);
    return mp_const_none;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(mp_vfs_read_obj, 4, 4, mp_vfs_read);


mp_obj_t mp_vfs_rmdir(mp_obj_t path_in) {
    return mp_const_none;
}
MP_DEFINE_CONST_FUN_OBJ_1(mp_vfs_rmdir_obj, mp_vfs_rmdir);


mp_obj_t mp_vfs_chdir(mp_obj_t path_in) {
    const char* path = mp_obj_str_get_str(path_in);
    
    API_FS_ChangeDir(path);
    return mp_const_none;
}
MP_DEFINE_CONST_FUN_OBJ_1(mp_vfs_chdir_obj, mp_vfs_chdir);


mp_obj_t mp_vfs_getcwd(void) {
    char* tmp_dir = API_FS_GetCurDir();
    // not implemented yet:
    // if not TLD, cut trailing '/'
    // don't know if required or useful.
    // If yes, this is the code:
    // char* tmp_dir = API_FS_FullPath("");
    // if (strcmp(tmp_dir, "/") != 0) {
        // tmp_dir[strlen(tmp_dir) - 1] = '\0';
    // }
    mp_obj_t retVal = mp_obj_new_str(tmp_dir, strlen(tmp_dir));
    // free(tmp_dir);
    return retVal;
}
MP_DEFINE_CONST_FUN_OBJ_0(mp_vfs_getcwd_obj, mp_vfs_getcwd);


mp_obj_t mp_vfs_stat(mp_obj_t path_in) {
    spiffs_stat stat;
    char* path = API_FS_FullPath(mp_obj_str_get_str(path_in));
    if(path == NULL) {
        mp_raise_OSError(MP_EIO);
    }

    s32_t ret = 0;
    if (strcmp(path,"/") == 0) { // the only existing dir.
        stat = (spiffs_stat){.type = 2, .size = 0, .obj_id = 0};
    } else {
        SPIFFS_stat(&fs, path, &stat);
    }
    free(path);
    if(ret != 0) {
        mp_raise_OSError(MP_EIO);
    }

    mp_obj_tuple_t *t = MP_OBJ_TO_PTR(mp_obj_new_tuple(10, NULL));
    if (stat.type == 2) { // Directory
        t->items[0] = MP_OBJ_NEW_SMALL_INT(0040000); // ISDIR
    } else { // default to file
        t->items[0] = MP_OBJ_NEW_SMALL_INT(0100777); // ISREG
    }
    t->items[1] = MP_OBJ_NEW_SMALL_INT(stat.obj_id); // Inode = ID
    for (int i = 2; i <= 9; ++i) {
        t->items[i] = MP_OBJ_NEW_SMALL_INT(0); // 
    }
    t->items[6] = MP_OBJ_NEW_SMALL_INT(stat.size); // Size
    return MP_OBJ_FROM_PTR(t);
}
MP_DEFINE_CONST_FUN_OBJ_1(mp_vfs_stat_obj, mp_vfs_stat);

mp_obj_t mp_vfs_statvfs(mp_obj_t path_in) {
    u32_t total, used;

    s32_t ret = SPIFFS_info(&fs, &total, &used);
    if(ret != 0) {
        mp_raise_OSError(MP_EIO);
    }
    mp_obj_tuple_t *t = MP_OBJ_TO_PTR(mp_obj_new_tuple(10, NULL));
    t->items[0] = mp_obj_new_int(total);
    t->items[1] = mp_obj_new_int(used);
    for (int i = 2; i <= 9; ++i) {
        t->items[i] = MP_OBJ_NEW_SMALL_INT(0); // 
    }
    return MP_OBJ_FROM_PTR(t);
}
MP_DEFINE_CONST_FUN_OBJ_1(mp_vfs_statvfs_obj, mp_vfs_statvfs);

#endif //#if !MICROPY_VFS

STATIC const mp_rom_map_elem_t os_module_globals_table[] = {
    { MP_ROM_QSTR(MP_QSTR___name__), MP_ROM_QSTR(MP_QSTR_uos) },
    { MP_ROM_QSTR(MP_QSTR_uname), MP_ROM_PTR(&os_uname_obj) },
    { MP_ROM_QSTR(MP_QSTR_urandom), MP_ROM_PTR(&os_urandom_obj) },
    #if MICROPY_PY_OS_DUPTERM
    { MP_ROM_QSTR(MP_QSTR_dupterm), MP_ROM_PTR(&mp_uos_dupterm_obj) },
    { MP_ROM_QSTR(MP_QSTR_dupterm_notify), MP_ROM_PTR(&os_dupterm_notify_obj) },
    #endif
    #if MICROPY_VFS
    { MP_ROM_QSTR(MP_QSTR_ilistdir), MP_ROM_PTR(&mp_vfs_ilistdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_listdir), MP_ROM_PTR(&mp_vfs_listdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_mkdir), MP_ROM_PTR(&mp_vfs_mkdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_rmdir), MP_ROM_PTR(&mp_vfs_rmdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_chdir), MP_ROM_PTR(&mp_vfs_chdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_getcwd), MP_ROM_PTR(&mp_vfs_getcwd_obj) },
    { MP_ROM_QSTR(MP_QSTR_remove), MP_ROM_PTR(&mp_vfs_remove_obj) },
    { MP_ROM_QSTR(MP_QSTR_rename), MP_ROM_PTR(&mp_vfs_rename_obj) },
    { MP_ROM_QSTR(MP_QSTR_stat), MP_ROM_PTR(&mp_vfs_stat_obj) },
    { MP_ROM_QSTR(MP_QSTR_statvfs), MP_ROM_PTR(&mp_vfs_statvfs_obj) },
    { MP_ROM_QSTR(MP_QSTR_mount), MP_ROM_PTR(&mp_vfs_mount_obj) },
    { MP_ROM_QSTR(MP_QSTR_umount), MP_ROM_PTR(&mp_vfs_umount_obj) },
    #if MICROPY_VFS_FAT
    { MP_ROM_QSTR(MP_QSTR_VfsFat), MP_ROM_PTR(&mp_fat_vfs_type) },
    #endif
    #endif
    #if !MICROPY_VFS
    //{ MP_ROM_QSTR(MP_QSTR_ilistdir), MP_ROM_PTR(&mp_vfs_ilistdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_listdir), MP_ROM_PTR(&mp_vfs_listdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_ls), MP_ROM_PTR(&mp_vfs_ls_obj) },
    { MP_ROM_QSTR(MP_QSTR_mkdir), MP_ROM_PTR(&mp_vfs_mkdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_rmdir), MP_ROM_PTR(&mp_vfs_rmdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_chdir), MP_ROM_PTR(&mp_vfs_chdir_obj) },
    { MP_ROM_QSTR(MP_QSTR_getcwd), MP_ROM_PTR(&mp_vfs_getcwd_obj) },
    { MP_ROM_QSTR(MP_QSTR_write), MP_ROM_PTR(&mp_vfs_write_obj) },
    { MP_ROM_QSTR(MP_QSTR_read), MP_ROM_PTR(&mp_vfs_read_obj) },
    { MP_ROM_QSTR(MP_QSTR_remove), MP_ROM_PTR(&mp_vfs_remove_obj) },
    { MP_ROM_QSTR(MP_QSTR_rename), MP_ROM_PTR(&mp_vfs_rename_obj) },
    { MP_ROM_QSTR(MP_QSTR_stat), MP_ROM_PTR(&mp_vfs_stat_obj) },
    { MP_ROM_QSTR(MP_QSTR_statvfs), MP_ROM_PTR(&mp_vfs_statvfs_obj) },
    { MP_ROM_QSTR(MP_QSTR_formatfs), MP_ROM_PTR(&mp_vfs_formatfs_obj) },
    { MP_ROM_QSTR(MP_QSTR_SEEK_SET), MP_ROM_INT(0) },
    { MP_ROM_QSTR(MP_QSTR_SEEK_CUR), MP_ROM_INT(1) },
    { MP_ROM_QSTR(MP_QSTR_SEEK_END), MP_ROM_INT(2) },
    //{ MP_ROM_QSTR(MP_QSTR_mount), MP_ROM_PTR(&mp_vfs_mount_obj) },
    //{ MP_ROM_QSTR(MP_QSTR_umount), MP_ROM_PTR(&mp_vfs_umount_obj) },
    #if MICROPY_VFS_FAT
    { MP_ROM_QSTR(MP_QSTR_VfsFat), MP_ROM_PTR(&mp_fat_vfs_type) },
    #endif
    #endif
};

STATIC MP_DEFINE_CONST_DICT(os_module_globals, os_module_globals_table);

const mp_obj_module_t uos_module = {
    .base = { &mp_type_module },
    .globals = (mp_obj_dict_t*)&os_module_globals,
};
