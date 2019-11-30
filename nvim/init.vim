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
Plug 'tpope/vim-projectionist'

"===== Syntax Awareness =====
"Plug 'neomake/neomake'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
Plug 'flowtype/vim-flow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"===== Formatting and Linting ======
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'ruby'] },
Plug 'mhinz/vim-mix-format',


call plug#end()

let g:polyglot_disabled = ['markdown', 'haml']

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

"if !exists('g:deoplete#omni#input_patterns')
  "let g:deoplete#omni#input_patterns = {}
"endif
""  let g:deoplete#disable_auto_complete = 1
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"let g:deoplete#enable_at_startup = 1
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"call deoplete#enable()

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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.rb PrettierAsync

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
let g:move_key_modifier = 'D'

"autocmd! BufWritePost * Neomake

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
