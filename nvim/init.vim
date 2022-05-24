"Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'windwp/nvim-autopairs'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'
Plug 'mattn/emmet-vim'
Plug 'ahmedkhalf/project.nvim'
Plug 'beauwilliams/focus.nvim'
Plug 'rafamadriz/friendly-snippets'
call plug#end()

" LSP
lua require('lsp-config')
lua require('projects')

set completeopt=menu,menuone,noselect
" Themes

let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ }

let g:gruvbox_transparent_bg=1
let g:gruvbox_italic=1
let g:gruvbox_number_column='bg1'

set termguicolors

autocmd vimenter * ++nested colorscheme gruvbox

autocmd vimenter * highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE

set laststatus=2
set noshowmode
syntax enable

"Options

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
set signcolumn=yes 
set timeoutlen=200
set hlsearch 
set showcmd
let g:user_emmet_leader_key='<Space>'

"Nerdtree

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
:let g:NERDTreeWinSize=70

" Keybindings

:let mapleader = ' '
inoremap jj <ESC>
nnoremap WW :w<cr>
inoremap <c-s> <ESC>:w<cr>a
nnoremap <c-s> :w<cr>

" Telescope

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fp <cmd>Telescope projects<CR>
