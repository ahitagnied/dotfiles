mkcd() { mkdir -p "$1" && cd "$1"; }

extract() {
    [[ ! -f "$1" ]] && echo "extract: '$1' is not a file" >&2 && return 1
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz)         tar xJf "$1" ;;
        *.tar)             tar xf "$1"  ;;
        *.bz2)     bunzip2 "$1" ;;
        *.gz)      gunzip "$1"  ;;
        *.rar)     unrar x "$1" ;;
        *.zip)     unzip "$1"   ;;
        *.7z)      7z x "$1"    ;;
        *) echo "extract: unknown format '$1'" >&2; return 1 ;;
    esac
}

tre() { tree -aC -I '.git|node_modules|__pycache__|.venv' --dirsfirst "${@:-.}" | less -FR; }
ff() { find . -type f -iname "*${1}*" 2>/dev/null; }
fdir() { find . -type d -iname "*${1}*" 2>/dev/null; }

up() {
    local p=""
    for ((i = 0; i < ${1:-1}; i++)); do p+="../"; done
    cd "$p" || return
}

port() { lsof -i :"$1" 2>/dev/null; }

killport() {
    local pid=$(lsof -ti :"$1" 2>/dev/null)
    [[ -n "$pid" ]] && kill -9 "$pid" && echo "killed $pid" || echo "nothing on port $1"
}

weather() { curl -s "wttr.in/${1:-}" | head -37; }
cheat() { curl -s "cheat.sh/$1"; }
gitignore() { curl -sL "https://www.toptal.com/developers/gitignore/api/$1"; }
serve() { python3 -m http.server "${1:-8000}"; }

note() {
    local f="$HOME/notes.md"
    [[ $# -eq 0 ]] && { cat "$f" 2>/dev/null || echo "no notes yet"; return; }
    echo "- $(date '+%Y-%m-%d %H:%M') $*" >> "$f"
}
