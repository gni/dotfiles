# Dotfiles

Configuration files for `zsh`, `vim`, `tmux`, and `git`. Works on Linux and macOS.

## Install

```bash
git clone https://github.com/gni/dotfiles ~/dotfiles
cd ~/dotfiles
make install
```

The installer will:
1. Show a dry-run of all changes and ask for confirmation
2. Install Oh-My-Zsh if not present
3. Back up existing files before replacing them
4. Symlink configs (zshrc, vimrc, tmux.conf, editorconfig, curlrc, wgetrc)
5. Include shared git config via `[include]` — your identity and custom settings are never touched
6. Install vim-plug and plugins
7. Install zsh plugins and themes

## Update

```bash
make update
```

## Uninstall

```bash
make uninstall
```

Removes symlinks. Restore originals from `~/.dotfiles_backup_*` if needed.

## Structure

```
dotfiles/
├── git/
│   └── .gitconfig-shared   # Git aliases and settings (included, not replaced)
├── tmux/
│   └── .tmux.conf          # Tmux configuration
├── vim/
│   └── .vimrc              # Vim configuration
├── zsh/
│   ├── aliases.zsh         # Shell aliases (OS-aware)
│   ├── config.zsh          # Zsh settings and key bindings
│   ├── exports.zsh         # Environment variables and PATH
│   ├── functions.zsh       # Custom functions
│   └── plugins.zsh         # Oh-My-Zsh plugin list (conditional)
├── .curlrc                 # Curl defaults
├── .editorconfig           # Editor formatting rules
├── .wgetrc                 # Wget defaults
├── install.sh              # Installer
├── update.sh               # Updater
├── Makefile                # make install / update / uninstall
└── zshrc                   # Main shell config
```

## Zsh

- **Theme**: [traistă](https://github.com/gni/traista) — async two-line prompt with git status
- **Plugins**: gitfast, last-working-dir, common-aliases, zsh-syntax-highlighting, history-substring-search, zsh-autosuggestions
- **Conditional plugins**: docker, podman, kubectl, helm, terraform, aws, ansible, npm, yarn, pip, golang, rust — loaded only if the tool is installed
- **Auto-venv**: activates/deactivates Python virtualenv on `cd`
- **OS detection**: Linux and macOS aliases loaded conditionally
- **Lazy loading**: rbenv, nvm/fnm, pyenv initialized on first use
- **History**: 50k entries, dedup, shared across sessions

## Vim

- **Plugin manager**: vim-plug
- **Theme**: Gruvbox (dark, hard contrast)
- **Plugins**: vim-airline, nerdtree, fzf, vim-polyglot, coc.nvim, vim-fugitive, vim-surround, vim-commentary, auto-pairs
- **Keys**: `Ctrl+n` NERDTree, `Ctrl+p` FZF, `gd`/`gy`/`gi`/`gr` CoC navigation

## Tmux

- **Prefix**: `Ctrl+a`
- **Splits**: `|` horizontal, `-` vertical
- **Navigation**: vim-style `h/j/k/l`
- **Mouse**: enabled
- **Copy mode**: vi keybindings

## Git

- **Aliases**: `st`, `co`, `br`, `lg` (graph log), `ll` (pretty log), `undo`, `wip`
- **Settings**: rebase on pull, auto setup remote, prune on fetch, diff3 conflicts

## Aliases

| Category | Examples |
|----------|---------|
| **Git** | `gs`, `ga`, `gc`, `gp`, `gpl`, `gf`, `gco`, `gb`, `gd`, `gl`, `gst` |
| **Docker** | `dps`, `dpa`, `dst`, `dexec`, `dlogs`, `dimages`, `dcup`, `dcdown` |
| **Podman** | `pps`, `ppa`, `pexec`, `plogs`, `pcup`, `pcdown` |
| **Kubernetes** | `k`, `kgp`, `kgd`, `kgs`, `kl`, `klf`, `kex`, `kaf`, `kctx` |
| **Terraform** | `tf`, `tfi`, `tfp`, `tfa`, `tfaa`, `tfs`, `tfo`, `tfv` |
| **AWS** | `awswho`, `awsec2`, `awss3`, `awslambda`, `awseks` |
| **Ansible** | `ans`, `ansp`, `ansv`, `ansg`, `ansping` |
| **Python** | `py`, `pip`, `pipi`, `venv`, `activate` |
| **Node** | `ni`, `nrs`, `nrb`, `nrt`, `nrd`, `yi`, `yrs`, `yrb` |
| **Go** | `gor`, `gob`, `got`, `gof`, `gomod` |
| **Rust** | `cr`, `cb`, `ct`, `cf`, `ccl` |
| **Network** | `extip`, `localip`, `ports`, `ping`, `http`, `headers` |
| **Security** | `sslcheck`, `genpass`, `b64e`, `b64d`, `suidfiles` |
| **Files** | `l`, `ll`, `la`, `ltr`, `ff`, `fd`, `duf`, `cpv`, `tarc`, `tarx` |

## License

MIT
