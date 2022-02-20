"install plug-vim
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Status line
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Themes
Plug 'sainnhe/gruvbox-material'

" Icons
Plug 'ryanoasis/vim-devicons' 

" Search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Side bars
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Highlight
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" GIT
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Terminal
Plug 'akinsho/toggleterm.nvim'
call plug#end()

colorscheme gruvbox-material

set nobackup
set noswapfile
set number
set background=dark
set noshowmode
set expandtab
set tabstop=4
set shiftwidth=4
set termguicolors 
set hidden
set cmdheight=2 " Give more space for displaying messages.
set fillchars+=eob:\ 

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

" call lua plugins
lua << END
--require("config")
require("lualine-config")
require("toggleterm-config")
require'nvim-tree'.setup()
END

" set leader to space
let mapleader = " "

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>] <cmd>Gitsigns next_hunk<cr>
nnoremap <leader>[ <cmd>Gitsigns prev_hunk<cr>
nnoremap <leader>hs <cmd>Gitsigns stage_hunk<cr>
nnoremap <leader>hr <cmd>Gitsigns reset_hunk<CR><cr>

" NvimTree
nmap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" Load COC settings
" source ~/.config/nvim/config/coc-settings.vim

autocmd CursorHold * silent call CocActionAsync('highlight')
