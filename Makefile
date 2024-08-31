scripts_dir := scripts
arg :=

.PHONY: help change_root_dir disable_gpu select_shell setup sync_git_user clean

help:
	@echo "Usage: make [target] [arg=<arg>]"
	@echo ""
	@echo "  targets:"
	@echo "    setup \e[32m[default]\e[m  create directories for mount"
	@echo "    help             show this help message"
	@echo "    change_root_dir  change root directory for mount (arg=<new_root_dir>)"
	@echo "    disable_gpu      disable gpu ([option] arg=enable_gpu)"
	@echo "    select_shell     select shell (arg=bash or zsh)"
	@echo "    sync_git_user    sync git user, email, and ssh key ([option] arg=disable)"
	@echo "    clean            clean"
	@echo ""
	@echo "  show help of target:"
	@echo "    make [target] arg=-h"
	@echo ""
	@echo "For normal setup, only “\e[32mmake setup\e[m“ is required."

change_root_dir:
	@$(scripts_dir)/change_root_dir.sh $(arg)

disable_gpu:
	@$(scripts_dir)/disable_gpu.sh $(arg)

select_shell:
	@$(scripts_dir)/select_shell.sh $(arg)

setup:
	@$(scripts_dir)/setup.sh $(arg)

sync_git_user:
	@$(scripts_dir)/sync_git_user.sh $(arg)

clean:
	@$(scripts_dir)/setup.sh clean
	@git checkout -- .
	@if [ -f root_dir.log ]; then rm root_dir.log; fi
