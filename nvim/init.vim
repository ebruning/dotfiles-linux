"install plug-vim
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Appearence {{{ "
Plug 'itchyny/lightline.vim'		" Status line
Plug 'connorholyday/vim-snazzy'
Plug 'dylanaraps/wal.vim'
Plug 'mhinz/vim-startify'
Plug 'cocopon/iceberg.vim'
Plug 'doums/darcula'
Plug 'dracula/vim', { 'name': 'dracula' }

" Side bars{{{
Plug 'scrooloose/nerdtree'		" NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin' 	" show git status in Nerd tree
Plug 'mbbill/undotree'
Plug  'preservim/tagbar'
" }}}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " Completion as in vscode
Plug 'junegunn/goyo.vim' " start menu
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'sheerun/vim-polyglot' "all lang packs :)


"JS {{{
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier'
Plug 'dense-analysis/ale' "ES-Lint
Plug 'pangloss/vim-javascript'
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx','typescript'],  'do': 'make install' }
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'SirVer/ultisnips'
Plug 'albanm/vuetify-vim'
"}}}

"}}}
" Markdown {{{
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"}}}
" GIT {{{
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" }}}

Plug 'ryanoasis/vim-devicons' " icons
Plug 'ap/vim-css-color'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" vim settinga
colorscheme dracula

if !has('gui_running')
  set t_Co=256
endif

set encoding=utf-8
set number
set background=dark
set laststatus=2
set nocompatible                
set encoding=utf-8
set nobackup
set noswapfile
set splitright
set splitbelow
set noshowmode  " Don't show mode since using status line
set hidden
set cmdheight=2

" MacVim specific settings
if has("gui_macvim")
  set guifont=Hack\ Nerd\ Font:h14
endif

" Commenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" Nerd Tree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",  
    "\ "Ignored"   : "#808080"  
    "\ }                        

let g:NERDTreeIgnore = ['^node_modules$']

" CTRL-P
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" coc config
"let g:coc_global_extensions = [
"  \ 'coc-snippets',
"  \ 'coc-pairs',
"  \ 'coc-tsserver',
"  \ 'coc-eslint',
"  \ 'coc-prettier',
"  \ 'coc-json',
"  \ ]

" auto folds
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-html', 
  \ 'coc-css', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emoji',
  \ ]

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Lightline
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

"let g:coc_node_path ='/Users/ethan/.nvm/versions/node/v10.16.0/bin/node'

" Gitgutter config for darkula
" hi! link GitGutterAdd GitAddStripe
" hi! link GitGutterChange GitChangeStripe
" hi! link GitGutterDelete GitDeleteStripe
" let g:gitgutter_sign_removed = '▶'

" coc config
" ======
" use tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"use enter to confirm completion
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

