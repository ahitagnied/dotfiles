syntax on
set number relativenumber
set background=dark
set termguicolors
filetype plugin indent on
colorscheme desert
set cursorline showmatch signcolumn=yes

set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab smartindent autoindent

set incsearch hlsearch ignorecase smartcase

set mouse=a
set scrolloff=8 sidescrolloff=8
set wildmenu wildmode=longest:full,full
set splitbelow splitright
set hidden
set updatetime=250
set clipboard=unnamed

set nobackup nowritebackup noswapfile
set undofile undodir=~/.vim/undodir

let mapleader = " "

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
