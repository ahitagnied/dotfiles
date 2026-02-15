# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# ls
if command -v eza &>/dev/null; then
    alias ls="eza --group-directories-first"
    alias ll="eza -alh --git --group-directories-first"
    alias lt="eza --tree --level=2 --group-directories-first"
else
    alias ls="ls -G"
    alias ll="ls -alFhG"
fi
alias la="ls -A"

# don't nuke things by accident
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias grep="grep --color=auto"

# git
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph --decorate -20"
alias gla="git log --oneline --graph --decorate --all"
alias gb="git branch"
alias gco="git checkout"
alias gsw="git switch"
alias gst="git stash"
alias gstp="git stash pop"
alias gundo="git reset --soft HEAD~1"

# python
alias py="python3"
alias pip="python3 -m pip"
alias activate="source .venv/bin/activate"
alias ca="conda activate"
alias jn="jupyter notebook"
alias jl="jupyter lab"

# docker
alias dk="docker"
alias dkc="docker compose"
alias dkps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# network
alias myip="curl -s ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias ports="lsof -iTCP -sTCP:LISTEN -nP"

# misc
alias cls="clear"
alias h="history"
alias now="date '+%Y-%m-%d %H:%M:%S'"
alias path='echo -e ${PATH//:/\\n}'
alias reload="source ~/.bashrc && echo 'reloaded'"
alias dotfiles="cd ~/Desktop/dotfiles"

# macos
if [[ "$(uname)" == "Darwin" ]]; then
    alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
    alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
    alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"
    alias brewup="brew update && brew upgrade && brew cleanup"
fi
