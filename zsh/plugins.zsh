# Core plugins (always loaded)
plugins=(
  gitfast
  last-working-dir
  common-aliases
  zsh-syntax-highlighting
  history-substring-search
  zsh-autosuggestions
)

# Conditionally add tool-specific plugins only if the tool is installed
(( $+commands[rbenv] ))    && plugins+=(rbenv)
(( $+commands[docker] ))   && plugins+=(docker docker-compose)
(( $+commands[podman] ))   && plugins+=(podman)
(( $+commands[kubectl] ))  && plugins+=(kubectl)
(( $+commands[helm] ))     && plugins+=(helm)
(( $+commands[terraform] )) || (( $+commands[tofu] )) && plugins+=(terraform)
(( $+commands[aws] ))      && plugins+=(aws)
(( $+commands[ansible] ))  && plugins+=(ansible)
(( $+commands[npm] ))      && plugins+=(npm)
(( $+commands[yarn] ))     && plugins+=(yarn)
(( $+commands[pip] )) || (( $+commands[pip3] )) && plugins+=(pip)
(( $+commands[go] ))       && plugins+=(golang)
(( $+commands[rustc] ))    && plugins+=(rust)
