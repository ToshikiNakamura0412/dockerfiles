scripts_dir := scripts
args :=

.PHONY: help change_root_dir disable_gpu select_shell setup sync_git_user clean

help:
	@echo "Usage: make [target] [args=\"<args>\"]"
	@echo ""
	@echo "  targets:"
	@echo "    setup \e[32m[default]\e[m  create directories for mount"
	@echo "    help             show this help message"
	@echo "    change_root_dir  change root directory for mount (args=<new_root_dir>)"
	@echo "    disable_gpu      disable gpu ([option] args=enable_gpu)"
	@echo "    select_shell     select shell (args=bash or zsh)"
	@echo "    sync_git_user    sync git user, email, and ssh key ([option] args=disable)"
	@echo "    clean            clean"
	@echo ""
	@echo "  show help of target:"
	@echo "    make [target] args=-h"
	@echo ""
	@echo "For normal setup, only “\e[32mmake setup\e[m“ is required."

change_root_dir:
	@$(scripts_dir)/change_root_dir.sh $(args)

disable_gpu:
	@$(scripts_dir)/disable_gpu.sh $(args)

select_shell:
	@$(scripts_dir)/select_shell.sh $(args)

setup:
	@$(scripts_dir)/setup.sh $(args)

sync_git_user:
	@$(scripts_dir)/sync_git_user.sh $(args)

clean:
	@git checkout -- .
	@if [ -f root_dir.log ]; then rm root_dir.log; fi
