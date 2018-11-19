#include <string.h>

#include "py/objtuple.h"
#include "py/objstr.h"
#include "py/runtime.h"
#include "py/mperrno.h"
#include "py/mphal.h"
#include "extmod/misc.h"
#include "py/lexer.h"
#include "genhdr/mpversion.h"
mp_import_stat_t mp_vfs_import_stat(const char *path) {

    //if (st_mode & MP_S_IFDIR) {
    //    return MP_IMPORT_STAT_DIR;
    //} else {
    //    return MP_IMPORT_STAT_FILE;
    //}

    //if (SPIFFS_stat(&fs,path, &st) == 0) {
        return MP_IMPORT_STAT_FILE;
    //}else{
        //return MP_IMPORT_STAT_NO_EXIST;
    //}
    
}