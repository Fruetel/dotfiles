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

set listchars=eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<

" Remove trailing white space
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin('~/.vim/plugged')

"===== Airline =====
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"===== Color Schemes =====
Plug 'whatyouhide/vim-gotham'
Plug 'nanotech/jellybeans.vim'

Plug 'janko-m/vim-test'

"===== Git Integration =====
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

"===== Editing Efficiency =====
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter',
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'

"===== Navigation and Search =====
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"===== Syntax Awareness =====
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sheerun/vim-polyglot'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-syntastic/syntastic'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
Plug 'flowtype/vim-flow'

"===== Formatting and Linting ======
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue'] },
Plug 'mhinz/vim-mix-format',


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
"colorscheme gotham
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

if executable('rg')
  " Use ripgrep over Grep
  set grepprg=rg\ --vimgrep
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

