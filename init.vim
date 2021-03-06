"Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Themes

let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ }

autocmd vimenter * colorscheme gruvbox
set laststatus=2
set noshowmode
syntax enable

" Options

set termguicolors
set number        
set relativenumber 
set cursorline
set ignorecase
set showmatch
set fileencoding=utf-8
set shiftwidth=2
set smarttab
set cindent
set expandtab
set clipboard=unnamed,unnamedplus

" Nerdtree

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Keybindings

:let mapleader = ' '
inoremap jj <ESC>
