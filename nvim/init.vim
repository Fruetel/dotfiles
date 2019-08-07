set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set backspace=indent,eol,start
set number
set incsearch

set showmatch
set colorcolumn=81
let test#strategy = "neovim"

" Using the mouse is helpful when scrolling through backraces
set mouse=a

" Remove trailing white space
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter',
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'whatyouhide/vim-gotham'
Plug 'janko-m/vim-test'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'matze/vim-move'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-syntastic/syntastic'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue'] },
Plug 'mhinz/vim-mix-format',
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
Plug 'flowtype/vim-flow'

call plug#end()

let g:polyglot_disabled = ['markdown', 'haml']

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
"  let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
call deoplete#enable()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" colorscheme gotham
colorscheme jellybeans

let mapleader=","
nmap <leader>gv :vsplit $MYVIMRC<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>r :source ~/.config/nvim/init.vim<cr>:AirlineRefresh<cr>
nmap <leader>f :split<cr><C-w>j:Nyancat<cr>
nmap <leader><leader> :redraw!<cr>
nmap <leader>R :below 10sp term://'rubocop -a'<cr>:e!<cr>:redraw!<cr>:AirlineRefresh<cr>

vmap <leader>j :!python -m json.tool<cr>

" Insult me for using cursor keys
map <left>  gg=G``
map <right> :echo "No cursor, you idiot"<cr>
map <up>    :echo "No cursor, you idiot"<cr>
map <down>  :echo "No cursor, you idiot"<cr>

"Terrible fix for nvim bug mapping <C-h> to <BS>
nmap <BS> <C-w>h
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nmap <C-p> :FZF<cr>
set diffopt+=vertical

set laststatus=2 " Always display the statusline in all windows
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Run prettier when saving
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue PrettierAsync

" Run mix format when saving
let g:mix_format_on_save = 1

let g:airline_powerline_fonts = 1

let g:flow#autoclose = 1

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

"set up vim move keys
let g:move_key_modifier = 'A'

autocmd! BufWritePost * Neomake

