set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set backspace=indent,eol,start

set showmatch
set colorcolumn=81

" Autocompletion on tab
set wildmenu

" execute pathogen#infect()



" TODO: Finish vundle setup
" http://tilvim.com/2013/12/28/pathogen-for-vundle.html
"
runtime include/vundle.vim

syntax on
syntax enable
filetype plugin indent on

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set number
autocmd BufWritePre * :%s/\s\+$//e

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

set term=screen-256color
set background=dark
" colorscheme sierra
" colorscheme gotham256
colorscheme detailed

let mapleader=","
nmap <leader>gv :vsplit $MYVIMRC<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>r :source ~/.vimrc<cr>:AirlineRefresh<cr>
nmap <leader>f :split<cr><C-w>j:Nyancat<cr>
nmap <leader><leader> :redraw!<cr>
nmap <leader>R :!rubocop -a<cr>:e!<cr>:redraw!<cr>:AirlineRefresh<cr>

vmap <leader>j :!python -m json.tool<cr>

" Insult me for using cursor keys
map <left>  :echo "No cursor, you idiot"<cr>
map <right> :echo "No cursor, you idiot"<cr>
map <up>    :echo "No cursor, you idiot"<cr>
map <down>  :echo "No cursor, you idiot"<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let g:airline_powerline_fonts = 1

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set diffopt+=vertical
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_error_symbol = "☠"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "☢"
let g:syntastic_style_warning_symbol = '💩'

" highlight link SyntasticError SpellBad
" highlight link SyntasticWarning SpellCap
