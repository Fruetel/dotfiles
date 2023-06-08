set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set backspace=indent,eol,start
set number
set incsearch

set ignorecase " Search case insensitive:
set smartcase " .. but not when search pattern contains upper case characters

set nobackup
set shortmess=Ia " Disable startup message

set showmatch

set colorcolumn=81
let test#strategy = "neovim"

" Using the mouse is helpful when scrolling through backraces
set mouse=a

set signcolumn=yes
set updatetime=250

set listchars=eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<

" Remove trailing white space
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin('~/.vim/plugged')

let mapleader=","

Plug 'file:///Users/tfruetel/documents/sources/vim-junior/', {'branch': 'main'}

"===== Airline =====
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"===== Color Schemes =====
Plug 'whatyouhide/vim-gotham'
Plug 'nanotech/jellybeans.vim'
Plug 'sickill/vim-monokai'
Plug 'rakr/vim-one'
Plug 'navarasu/onedark.nvim'


"===== Git Integration =====
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'

"===== Editing Efficiency =====
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter',
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'

"===== Navigation and Search =====
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
Plug 'tpope/vim-projectionist'
Plug 'ryanoasis/vim-devicons'

"===== Syntax Awareness =====
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim', {'branch': 'main'}
Plug 'MunifTanjim/prettier.nvim', {'branch': 'main'}
Plug 'williamboman/mason.nvim', { 'branch': 'main', 'do': ':MasonUpdate' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'github/copilot.vim', {'branch': 'release'}

"===== Completion =====
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets', { 'branch': 'main' }

Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }

"==== Testing =====
Plug 'janko-m/vim-test'

call plug#end()

lua <<EOF
require('gitsigns').setup()
require("mason").setup()

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}
lspconfig.solargraph.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "ruby",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_locally_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

EOF

"let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '~/.asdf/shims/python'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"colorscheme gotham
"colorscheme jellybeans
"colorscheme monokai

lua << EOF
require('onedark').setup {
    style = 'cool'
}
require('onedark').load()
EOF

"imap <silent><script><expr> <C-L> copilot#Accept()
"let g:copilot_no_tab_map = v:true

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufReadPost,FileReadPost * normal zR

nmap <leader>gv :vsplit $MYVIMRC<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>r :source ~/.config/nvim/init.vim<cr>:AirlineRefresh<cr>
nmap <leader>f :split<cr><C-w>j:Nyancat<cr>
nmap <leader><leader> :redraw!<cr>
nmap <leader>R :below 10sp term://'rubocop -a'<cr>:e!<cr>:redraw!<cr>:AirlineRefresh<cr>

" Insult me for using cursor keys
map <left> :echo "No cursor, you idiot"<cr>
map <right> :echo "No cursor, you idiot"<cr>
map <up>    :echo "No cursor, you idiot"<cr>
map <down>  :echo "No cursor, you idiot"<cr>

"Terrible fix for nvim bug mapping <C-h> to <BS>
nmap <BS> <C-w>h
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"if executable('rg')
  " Use ripgrep over Grep
  "set grepprg=rg\ --vimgrep
"endif
"set grepformat^=%f:%l:%c:%m

nmap <C-p> :Telescope find_files<cr>

set diffopt+=vertical

set laststatus=2 " Always display the statusline in all windows
set statusline+=%#warningmsg#
set statusline+=%*

let g:airline_powerline_fonts = 1

"let g:flow#autoclose = 1

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

"set up vim move keys
let g:move_key_modifier = 'D'
