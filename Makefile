.PHONY: install update uninstall

SYMLINK_TARGETS = ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.editorconfig ~/.wgetrc ~/.curlrc

install:
	@chmod +x install.sh
	@./install.sh

update:
	@chmod +x update.sh
	@./update.sh

uninstall:
	@echo "=== Dotfiles Uninstaller ==="
	@echo ""
	@echo "The following symlinks will be removed:"
	@for f in $(SYMLINK_TARGETS); do \
		if [ -L "$$f" ]; then \
			echo "  [remove symlink] $$f"; \
		fi; \
	done
	@echo ""
	@echo "Git include path for .gitconfig-shared will be removed."
	@echo ""
	@printf "Proceed? [y/N] "; \
	read reply; \
	case "$$reply" in \
		[yY]) ;; \
		*) echo "Aborted."; exit 1 ;; \
	esac
	@echo ""
	@for f in $(SYMLINK_TARGETS); do \
		if [ -L "$$f" ]; then \
			rm "$$f"; \
			echo "  Removed: $$f"; \
		fi; \
	done
	@git config --global --unset-all include.path 2>/dev/null || true
	@echo ""
	@LATEST=$$(ls -dt ~/.dotfiles_backup_* 2>/dev/null | head -1); \
	if [ -n "$$LATEST" ]; then \
		echo "Restoring from backup: $$LATEST"; \
		for f in "$$LATEST"/.??*; do \
			if [ -f "$$f" ]; then \
				cp "$$f" ~/.; \
				echo "  Restored: $$(basename $$f)"; \
			fi; \
		done; \
		echo ""; \
		echo "Backup restored. Review ~/.<files> to verify."; \
	else \
		echo "No backup found. You may need to recreate your configs manually."; \
	fi
	@echo ""
	@echo "Dotfiles uninstalled."
