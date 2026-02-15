#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

info() { echo -e "\033[1;34m[info]\033[0m  $*"; }
ok()   { echo -e "\033[1;32m[ok]\033[0m    $*"; }
warn() { echo -e "\033[1;33m[warn]\033[0m  $*"; }

link() {
    local src="$1" dst="$2"
    if [[ -e "$dst" || -L "$dst" ]]; then
        [[ "$(readlink "$dst" 2>/dev/null)" == "$src" ]] && ok "$dst (already linked)" && return
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/"
        warn "backed up $dst"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    ok "$dst -> $src"
}

info "linking dotfiles from $DOTFILES"
echo

link "$DOTFILES/bash/.bashrc"         "$HOME/.bashrc"
link "$DOTFILES/bash/.bash_profile"   "$HOME/.bash_profile"
link "$DOTFILES/bash/.bash_aliases"   "$HOME/.bash_aliases"
link "$DOTFILES/bash/.bash_functions" "$HOME/.bash_functions"
link "$DOTFILES/git/.gitconfig"       "$HOME/.gitconfig"
link "$DOTFILES/vim/.vimrc"           "$HOME/.vimrc"
link "$DOTFILES/.editorconfig"        "$HOME/.editorconfig"

echo
info "done — restart your terminal or: source ~/.bashrc"
[[ -d "$BACKUP" ]] && warn "old files backed up to $BACKUP"
