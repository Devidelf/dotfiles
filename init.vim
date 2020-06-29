"Plugins

call plug#begin('~/.nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

call plug#end()

" Themes

autocmd vimenter * colorscheme gruvbox

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ }
set laststatus=2
set noshowmode

" Options

set termguicolors
set number        
set relativenumber 
set cursorline
set ignorecase
set showmatch
set fileencoding=utf-8
set shiftwidth=4
set clipboard^=unnamed,unnamedplus

" Keybindings

:let mapleader = ' '
inoremap jj <ESC>
