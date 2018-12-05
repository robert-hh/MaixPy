SHELL := /bin/bash
do_mk:	
	$(shell touch k210_env)
	$(shell echo "export LD_LIBRARY_PATH=$$""LD_LIBRARY_PATH:"$(dir $(CROSS_COMPILE)) > k210_env)
	$(shell source k210_env)
