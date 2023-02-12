"Plugins
call plug#begin('~/.config/nvim/plugged')
"Plug 'morhetz/gruvbox'
Plug 'luisiacc/gruvbox-baby', {'branch':'main'}
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'windwp/nvim-autopairs'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip' 
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'
Plug 'mattn/emmet-vim'
Plug 'ahmedkhalf/project.nvim'
Plug 'beauwilliams/focus.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'folke/which-key.nvim'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'lukas-reineke/indent-blankline.nvim',
Plug 'brenoprata10/nvim-highlight-colors',
Plug '~/Repos/csscp'
call plug#end()

" Keybindings

let mapleader = ' '
inoremap jj <ESC>
inoremap jj <ESC>
xnoremap <c-c> <ESC>
nnoremap WW :w<cr>
inoremap <c-s> <ESC>:w<cr>a
nnoremap <c-s> :w<cr>

" Telescope

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fp <cmd>Telescope projects<CR>

" LSP

lua require('lsp-config')
lua require('projects')

set completeopt=menu,menuone,noselect

" Themes
set t_Co=256
set termguicolors

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
set softtabstop=2
set tabstop=2
set smarttab
set cindent
set expandtab
set clipboard=unnamed,unnamedplus
set signcolumn=yes 
set timeoutlen=200
set nohlsearch 
set showcmd

"Emmet
let g:user_emmet_leader_key='<Space>'
let g:user_emmet_mode='n'

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
