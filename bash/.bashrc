[[ $- != *i* ]] && return

export BASH_SILENCE_DEPRECATION_WARNING=1

# homebrew
if [[ -d /opt/homebrew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /usr/local/Homebrew ]]; then
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# path — only add if not already there
pathadd() { [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"; }
pathadd "$HOME/.local/bin"
pathadd "$HOME/bin"
pathadd "/opt/homebrew/opt/ruby/bin"
pathadd "/opt/homebrew/lib/ruby/gems/3.4.0/bin"

# conda
if [[ -f /opt/anaconda3/bin/conda ]]; then
    __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
        eval "$__conda_setup"
    elif [[ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]]; then
        source "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        pathadd "/opt/anaconda3/bin"
    fi
    unset __conda_setup
fi

[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# history
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd -:pwd:exit:clear:history"
shopt -s histappend

# shell behaviour
shopt -s checkwinsize cdspell dirspell autocd globstar nocaseglob

# prompt — show git branch and dirty state
__git_prompt() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    local d=""
    git diff --quiet 2>/dev/null || d="*"
    git diff --cached --quiet 2>/dev/null || d="${d}+"
    echo " ${branch}${d}"
}
PS1='\[\e[1;32m\]\u\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]\[\e[0;33m\]$(__git_prompt)\[\e[0m\] \$ '

# defaults
export EDITOR="vim"
export VISUAL="vim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-R --mouse"

# coloured man pages
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# tab completion
if [[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
    source /opt/homebrew/etc/profile.d/bash_completion.sh
elif [[ -r /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# source aliases and functions from wherever this file actually lives
DOTBASH="$(cd "$(dirname "$(readlink ~/.bashrc 2>/dev/null || echo ~/.bashrc)")" && pwd)"
for file in "$DOTBASH/.bash_aliases" "$DOTBASH/.bash_functions"; do
    [[ -r "$file" ]] && source "$file"
done
unset file DOTBASH

# machine-specific stuff goes here, not tracked
[[ -r "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
