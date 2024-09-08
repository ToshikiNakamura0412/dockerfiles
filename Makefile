scripts_dir := scripts
arg :=

.PHONY: help change_root_dir disable_gpu select_shell setup_gui setup sync_git_user clean

help:
	@echo "Usage: make [target] [arg=<arg>]"
	@echo ""
	@echo "  targets:"
	@printf "    setup \e[32m[default]\e[m  create directories for mount\n"
	@echo "    help             show this help message"
	@echo "    change_root_dir  change root directory for mount (arg=<new_root_dir>)"
	@echo "    disable_gpu      disable gpu ([option] arg=enable_gpu)"
	@echo "    select_shell     select shell (arg=bash or zsh)"
	@echo "    setup_gui        setup gui"
	@echo "    sync_git_user    sync git user, email, and ssh key ([option] arg=disable)"
	@echo "    clean            clean"
	@echo ""
	@echo "  show help of target:"
	@echo "    make [target] arg=-h"
	@echo ""
	@printf "For normal setup, only '\e[32mmake setup\e[m' is required.\n"

change_root_dir:
	@$(scripts_dir)/change_root_dir.bash $(arg)

disable_gpu:
	@$(scripts_dir)/disable_gpu.bash $(arg)

select_shell:
	@$(scripts_dir)/select_shell.bash $(arg)

setup_gui:
	@$(scripts_dir)/setup_gui.bash $(arg)

setup:
	@if [ "$(shell uname)" = "Darwin" ]; then $(scripts_dir)/disable_gpu.bash; fi
	@$(scripts_dir)/setup.bash $(arg)
	@$(scripts_dir)/setup_gui.bash

sync_git_user:
	@$(scripts_dir)/sync_git_user.bash $(arg)

clean:
	@$(scripts_dir)/setup.bash clean
	@git checkout -- .
	@if [ -f root_dir.log ]; then rm root_dir.log; fi
