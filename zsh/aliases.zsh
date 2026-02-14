# ============================================================================
#  Network & IP
# ============================================================================
alias extip="curl ipinfo.io/ip"
alias localip="hostname -I | awk '{print \$1}'"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias myip='curl -s ipinfo.io | python3 -m json.tool'
alias whois='whois -H'

# Quickly serve the current directory as HTTP
alias httprb='ruby -run -e httpd . -p 8000'
alias httpy='python -m http.server 8000'
alias httpjs='http-server'
alias httphp='php -S localhost:8000'

# Cross-platform network aliases
alias ping='ping -c 5'
alias dig='dig +nocmd'
alias nslookup='nslookup -type=any'
alias http='curl -I'
alias headers='curl -I'

# SSH
alias ssh='ssh -o StrictHostKeyChecking=accept-new'
alias ssha='ssh-add'
alias sshkeys='ls -la ~/.ssh/'
alias sshconfig='vim ~/.ssh/config'

# Network File Transfer
alias sftp='sftp -oBatchMode=no'
alias scp='scp -oBatchMode=no'

# ============================================================================
#  Docker
# ============================================================================
# Container management
alias dpa='docker ps -a'
alias dps='docker ps'
alias dst='docker stats'
alias dstart='docker start'
alias dstop='docker stop'
alias drestart='docker restart'
alias dexec='docker exec -it'
alias drun='docker run'
alias dlogs='docker logs'
alias dlogsf='docker logs -f'
alias dtop='docker top'
alias dkill='docker kill'
alias dwait='docker wait'
alias drm='docker rm'
alias drma='docker rm $(docker ps -aq) 2>/dev/null'

# Image management
alias dimages='docker images'
alias dinspect='docker image inspect'
alias dremove='docker image rm'
alias dpull='docker pull'
alias dpush='docker push'
alias dprune='docker system prune -af'
alias dclean='docker system prune -af --volumes'
alias ddangling='docker images -f "dangling=true" -q | xargs -r docker rmi'

# Volume management
alias dvolumes='docker volume ls'
alias dvinspect='docker volume inspect'
alias dvr='docker volume rm'
alias dvprune='docker volume prune -f'

# Network management
alias dnetworks='docker network ls'
alias dninspect='docker network inspect'
alias dnrm='docker network rm'

# Docker-compose
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcdownv='docker-compose down -v'
alias dcrestart='docker-compose restart'
alias dcb='docker-compose build'
alias dcbnc='docker-compose build --no-cache'
alias dcpull='docker-compose pull'
alias dcps='docker-compose ps'
alias dclogs='docker-compose logs'
alias dclogsf='docker-compose logs -f'
alias dcexec='docker-compose exec'
alias dcrun='docker-compose run --rm'

# Dockerfile build
dbu() { docker build -t="$1" .; }
dbunc() { docker build --no-cache -t="$1" .; }

# Show all docker-related aliases
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }

# ============================================================================
#  Podman (mirrors Docker aliases with 'p' prefix)
# ============================================================================
if command -v podman &>/dev/null; then
  alias pps='podman ps'
  alias ppa='podman ps -a'
  alias pst='podman stats'
  alias pstart='podman start'
  alias pstop='podman stop'
  alias prestart='podman restart'
  alias pexec='podman exec -it'
  alias prun='podman run'
  alias plogs='podman logs'
  alias plogsf='podman logs -f'
  alias prm='podman rm'
  alias prma='podman rm -a'

  alias pimages='podman images'
  alias ppull='podman pull'
  alias ppush='podman push'
  alias prmi='podman rmi'
  alias pprune='podman system prune -af'
  alias pclean='podman system prune -af --volumes'

  alias pvolumes='podman volume ls'
  alias pvprune='podman volume prune -f'

  alias pnetworks='podman network ls'

  # Podman-compose
  alias pcup='podman-compose up'
  alias pcupd='podman-compose up -d'
  alias pcdown='podman-compose down'
  alias pcps='podman-compose ps'
  alias pclogs='podman-compose logs'

  # Pod management
  alias ppods='podman pod ls'
  alias ppodstart='podman pod start'
  alias ppodstop='podman pod stop'
  alias ppodrm='podman pod rm'

  palias() { alias | grep 'podman' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }
fi

# ============================================================================
#  Git (beyond oh-my-zsh defaults)
# ============================================================================
alias gs='git status -sb'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull --rebase'
alias gf='git fetch --all --prune'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gm='git merge'
alias gms='git merge --squash'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gd='git diff'
alias gds='git diff --staged'
alias gdn='git diff --name-only'
alias gl='git log --oneline --graph --decorate -20'
alias gla='git log --oneline --graph --decorate --all'
alias glp='git log -p -3'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gt='git tag'
alias gbl='git blame -b -w'
alias gclean='git clean -fd'
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git log -1 --format="%s" | grep -q "WIP" && git reset HEAD~1'
alias greset='git reset HEAD'
alias gresethard='git reset --hard HEAD'

# ============================================================================
#  Kubernetes
# ============================================================================
if command -v kubectl &>/dev/null; then
  alias k='kubectl'
  alias kgp='kubectl get pods'
  alias kgpa='kubectl get pods --all-namespaces'
  alias kgd='kubectl get deployments'
  alias kgs='kubectl get services'
  alias kgn='kubectl get nodes'
  alias kgi='kubectl get ingress'
  alias kgns='kubectl get namespaces'
  alias kgcm='kubectl get configmaps'
  alias kgsec='kubectl get secrets'
  alias kgpv='kubectl get pv'
  alias kgpvc='kubectl get pvc'
  alias kge='kubectl get events --sort-by=".lastTimestamp"'

  alias kd='kubectl describe'
  alias kdp='kubectl describe pod'
  alias kdd='kubectl describe deployment'
  alias kds='kubectl describe service'
  alias kdn='kubectl describe node'

  alias kl='kubectl logs'
  alias klf='kubectl logs -f'
  alias klt='kubectl logs --tail=100'

  alias kex='kubectl exec -it'
  alias kaf='kubectl apply -f'
  alias kdf='kubectl delete -f'
  alias kpf='kubectl port-forward'
  alias kctx='kubectl config current-context'
  alias kns='kubectl config set-context --current --namespace'

  alias ktop='kubectl top pods'
  alias ktopn='kubectl top nodes'

  alias kroll='kubectl rollout status'
  alias krollr='kubectl rollout restart'
  alias krollh='kubectl rollout history'
  alias krollu='kubectl rollout undo'

  alias kdrain='kubectl drain --ignore-daemonsets --delete-emptydir-data'
  alias kcordon='kubectl cordon'
  alias kuncordon='kubectl uncordon'

  kalias() { alias | grep 'kubectl' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }
fi

# Helm
if command -v helm &>/dev/null; then
  alias h='helm'
  alias hls='helm list'
  alias hlsa='helm list --all-namespaces'
  alias hi='helm install'
  alias hu='helm upgrade'
  alias hui='helm upgrade --install'
  alias hun='helm uninstall'
  alias hs='helm search repo'
  alias hsh='helm search hub'
  alias hru='helm repo update'
  alias hra='helm repo add'
  alias hrl='helm repo list'
  alias hv='helm version'
fi

# ============================================================================
#  Terraform / OpenTofu
# ============================================================================
if command -v terraform &>/dev/null || command -v tofu &>/dev/null; then
  # Use tofu if available, otherwise terraform
  _tf_cmd=$(command -v tofu &>/dev/null && echo "tofu" || echo "terraform")
  alias tf="$_tf_cmd"
  alias tfi="$_tf_cmd init"
  alias tfp="$_tf_cmd plan"
  alias tfa="$_tf_cmd apply"
  alias tfaa="$_tf_cmd apply -auto-approve"
  alias tfd="$_tf_cmd destroy"
  alias tfs="$_tf_cmd state"
  alias tfsl="$_tf_cmd state list"
  alias tfss="$_tf_cmd state show"
  alias tfo="$_tf_cmd output"
  alias tfv="$_tf_cmd validate"
  alias tff="$_tf_cmd fmt -recursive"
  alias tfw="$_tf_cmd workspace"
  alias tfwl="$_tf_cmd workspace list"
  alias tfws="$_tf_cmd workspace select"
  alias tfwn="$_tf_cmd workspace new"
  alias tfimport="$_tf_cmd import"
  alias tfrefresh="$_tf_cmd refresh"
  unset _tf_cmd
fi

# ============================================================================
#  Security & Pentesting
# ============================================================================
# SSL/TLS inspection
alias sslcheck='openssl s_client -connect'
alias sslcert='openssl x509 -noout -text -in'
alias sslexpiry='openssl s_client -connect 2>/dev/null | openssl x509 -noout -dates'
alias sslgen='openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes'
alias sslverify='openssl verify'
alias sslhash='openssl x509 -noout -hash -in'

# Hashing
alias md5sum='md5sum'
alias sha1='shasum -a 1'
alias sha256='shasum -a 256'
alias sha512='shasum -a 512'

# Password generation
alias genpass='openssl rand -base64 32'
alias genpass16='openssl rand -base64 16'
alias genuuid='python3 -c "import uuid; print(uuid.uuid4())"'
alias genkey='openssl rand -hex 32'

# File permissions audit
alias worldwritable='find / -xdev -type f -perm -0002 2>/dev/null'
alias suidfiles='find / -xdev -type f -perm -4000 2>/dev/null'
alias sgidfiles='find / -xdev -type f -perm -2000 2>/dev/null'
alias noowner='find / -xdev -nouser -o -nogroup 2>/dev/null'

# Process & system inspection
alias psg='ps aux | grep -v grep | grep -i'
alias psmem='ps aux --sort=-%mem | head -20'
alias pscpu='ps aux --sort=-%cpu | head -20'
alias listening='lsof -i -P -n | grep LISTEN'
alias established='lsof -i -P -n | grep ESTABLISHED'
alias openfiles='lsof -c'

# Quick security checks
alias lastlogins='last -20'
alias failedlogins='lastb -20 2>/dev/null || journalctl -u sshd --since "1 week ago" | grep "Failed"'
alias authlog='sudo tail -f /var/log/auth.log 2>/dev/null || sudo tail -f /var/log/secure'
alias sshlogins='grep "Accepted" /var/log/auth.log 2>/dev/null || journalctl -u sshd | grep "Accepted"'

# Encoding / Decoding
alias b64e='base64'
alias b64d='base64 -d'
alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))"'

# ============================================================================
#  Development Tools
# ============================================================================
# Python
alias py='python3'
alias py2='python2'
alias pip='pip3'
alias pipi='pip install'
alias pipu='pip install --upgrade'
alias pipun='pip uninstall'
alias pipf='pip freeze'
alias pipr='pip install -r requirements.txt'
alias venv='python3 -m venv .venv'
alias activate='source .venv/bin/activate'

# Node.js / NPM / Yarn
alias ni='npm install'
alias nig='npm install -g'
alias nid='npm install --save-dev'
alias nrs='npm run start'
alias nrb='npm run build'
alias nrt='npm run test'
alias nrl='npm run lint'
alias nrd='npm run dev'
alias nrw='npm run watch'
alias nci='npm ci'
alias nau='npm audit'
alias nauf='npm audit fix'
alias npx='npx --yes'

alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yrm='yarn remove'
alias yrs='yarn start'
alias yrb='yarn build'
alias yrt='yarn test'
alias yrl='yarn lint'
alias yrd='yarn dev'

# Ruby / Bundler
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias bo='bundle outdated'

# Go
alias gor='go run'
alias gob='go build'
alias got='go test ./...'
alias gotv='go test -v ./...'
alias gof='go fmt ./...'
alias govet='go vet ./...'
alias gomod='go mod tidy'
alias goget='go get'

# Rust / Cargo
alias cr='cargo run'
alias cb='cargo build'
alias cbr='cargo build --release'
alias ct='cargo test'
alias cc='cargo check'
alias cf='cargo fmt'
alias ccl='cargo clippy'
alias ca='cargo add'
alias cw='cargo watch -x run'

# Make
alias m='make'
alias mb='make build'
alias mt='make test'
alias mc='make clean'

# ============================================================================
#  JSON / YAML / Data
# ============================================================================
alias jsonpp='python3 -m json.tool'
alias jsonval='python3 -c "import json,sys; json.load(sys.stdin); print(\"Valid JSON\")"'
alias yamlval='python3 -c "import yaml,sys; yaml.safe_load(sys.stdin); print(\"Valid YAML\")"'
alias csv='column -t -s,'

# jq shortcuts
alias jqkeys='jq keys'
alias jqlen='jq length'
alias jqraw='jq -r'

# ============================================================================
#  File Operations
# ============================================================================
alias l='ls -al'
alias ltr='ls -ltr'
alias lth='l -t|head'
alias lh='ls -Shl | less'
alias ll='ls -lah'
alias la='ls -A'
alias lsd='ls -ld */'
alias tf='tail -f -n 100'
alias cpv='rsync -ah --progress'
alias mkdir='mkdir -pv'
alias cls='clear'
alias h='history'
alias hg='history | grep'
alias j='jobs -l'
alias path='echo $PATH | tr ":" "\n"'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias timestamp='date +%s'
alias week='date +%V'

# File search
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# Disk Usage
alias duh='du -h'
alias duf='du -sh * | sort -rh'

# File Information
alias fileinfo='file -b'
alias filemime='file -i'

# Disk Usage Statistics
alias dfh='df -h'
alias dfi='df -i'

# File Comparison
alias diff='colordiff'

# Archive Creation
alias tarc='tar -czvf'
alias tarx='tar -xzvf'
alias tarbz='tar -cjvf'
alias tarxbz='tar -xjvf'

# Archive Extraction
alias un7z='7z x'
alias unrar='unrar x'
alias untar='tar -xzvf'
alias unzip='unzip -o'

# Quick edit common files
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias hosts='sudo vim /etc/hosts'
alias sshconf='vim ~/.ssh/config'

# ============================================================================
#  Systemd & Services (Linux)
# ============================================================================
if [[ "$DOTFILES_OS" == "Linux" ]]; then
  alias sc='systemctl'
  alias scstart='sudo systemctl start'
  alias scstop='sudo systemctl stop'
  alias screstart='sudo systemctl restart'
  alias scstatus='systemctl status'
  alias scenable='sudo systemctl enable'
  alias scdisable='sudo systemctl disable'
  alias screload='sudo systemctl daemon-reload'
  alias sclog='journalctl -u'
  alias sclogf='journalctl -fu'
  alias scfailed='systemctl --failed'
  alias sctimers='systemctl list-timers --all'
fi

# ============================================================================
#  Ansible
# ============================================================================
if command -v ansible &>/dev/null; then
  alias ans='ansible'
  alias ansp='ansible-playbook'
  alias ansv='ansible-vault'
  alias ansg='ansible-galaxy'
  alias ansi='ansible-inventory'
  alias ansl='ansible-lint'
  alias ansping='ansible all -m ping'
  alias ansfacts='ansible all -m setup'
fi

# ============================================================================
#  AWS CLI
# ============================================================================
if command -v aws &>/dev/null; then
  alias awswho='aws sts get-caller-identity'
  alias awsregions='aws ec2 describe-regions --output table'
  alias awsec2='aws ec2 describe-instances --output table'
  alias awss3='aws s3 ls'
  alias awslambda='aws lambda list-functions'
  alias awseks='aws eks list-clusters'
  alias awsrds='aws rds describe-db-instances'
  alias awsiam='aws iam list-users'
  alias awslogs='aws logs describe-log-groups'
  alias awscf='aws cloudformation list-stacks'
fi

# ============================================================================
#  Linux-only aliases
# ============================================================================
if [[ "$DOTFILES_OS" == "Linux" ]]; then
  alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
  alias ports='netstat -tuln'
  alias traceroute='traceroute -I'
  alias ifc='ifconfig'
  alias iw='iwconfig'
  alias arp='arp -a'
  alias nmap='sudo nmap'
  alias tcpdump='sudo tcpdump -i any'
  alias ss='ss -tunlp'
  alias mtr='sudo mtr'
  alias iftop='sudo iftop -nNP'
  alias ngrep='sudo ngrep -d any'
  alias mount='mount | column -t'

  # Wireless (NetworkManager)
  alias wifi='nmcli device wifi list'
  alias wifion='nmcli radio wifi on'
  alias wifioff='nmcli radio wifi off'

  # Firewall
  alias fwlist='sudo iptables -L -n -v --line-numbers'
  alias fwc='sudo ufw enable'
  alias fwa='sudo ufw allow'
  alias fwi='sudo ufw deny'
  alias fws='sudo ufw status'

  # Clipboard
  alias clip='xclip -selection clipboard'
  alias clippaste='xclip -selection clipboard -o'
fi

# ============================================================================
#  macOS-only aliases
# ============================================================================
if [[ "$DOTFILES_OS" == "Darwin" ]]; then
  alias ips="ifconfig -a | grep -o 'inet[^ ]*' | cut -d' ' -f2"
  alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
  alias traceroute='traceroute'
  alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
  alias mount='mount | column -t'

  # Wireless
  alias wifi='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s'

  # Firewall
  alias fwstatus='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate'

  # Clipboard
  alias clip='pbcopy'
  alias clippaste='pbpaste'
fi
