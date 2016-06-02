set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set backspace=indent,eol,start

set showmatch
set background=dark


" Autocompletion on tab
set wildmenu

execute pathogen#infect()
syntax on
filetype plugin indent on

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

colorscheme solarized
