filetype off " required
filetype plugin indent on " required

set title

set noerrorbells " No beeps
set number relativenumber " Show line numbers
set noswapfile " Don't use swapfile
set nobackup " Don't create annoying backup files
set nowritebackup
set splitright " Split vertical windows right to the current windows
set splitbelow " Split horizontal windows below to the current windows
set encoding=utf-8 " Set default encoding to UTF-8
set autoread " Automatically reread changed files without asking me anything

set incsearch " Shows the match while typing
set hlsearch  " Highlight found searches
set ignorecase " Search case insensitive
set smartcase " but not when search pattern contains upper case characters

set ttyfast

set lazyredraw " Wait to redraw

" Make Vim to handle long lines nicely.
set wrap
set textwidth=79
set formatoptions=qrn1

syntax on "turn on syntax highlighting

"set completeopt-=preview " Stops scratch window opening
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

set wildignore+=vendor/**

" remove banner from netrw
let g:netrw_banner = 0
let g:netrw_chgwin= -1
let g:netrw_winsize = 20

" tabs and indent
set tabstop=4
set shiftwidth=4

" finding files
set path+=**
set wildmenu

" map escape to something easier
inoremap jk <Esc>
inoremap kj <Esc>

" set spelling completion
set complete+=kspell

" common caps errors
:command WQ wq
:command Wq wq
:command W w
:command Q q

if empty(glob('~/.config/nvim/undo'))
	silent !mkdir ~/.config/nvim/undo > /dev/null 2>&1
endif

set undofile                " Save undos after file closes
set undodir=$HOME/.config/nvim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" remap ctrl + n & p to buffer navigation
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>

" Mapping selecting mappings
nmap <leader><tab> :Files<CR>

nnoremap <silent><leader>vt :vert term<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" Highlight trailing spaces
hi TrailingWhitespace ctermbg=red guibg=#f92672
:autocmd BufWinEnter * 2match TrailingWhitespace /\s\+$/

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-signify'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'pangloss/vim-javascript'
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'ncm2/ncm2'
Plug 'phpactor/ncm2-phpactor'
Plug 'roxma/nvim-yarp'
call plug#end()

" themes
"set termguicolors
"set background=dark
colorscheme monokai
"colorscheme nord
let g:molokai_original = 1

" airline ale
let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
\   'php': ['phpstan', 'phpmd', 'php'],
\}
let g:ale_lint_delay = 1000
let g:ale_php_phpstan_level = 4
let g:ale_php_phpmd_ruleset = 'unusedcode'

let g:ale_sign_error = '⚑⚑'
let g:ale_sign_warning = '⚐⚐'
let g:ale_cursor_detail = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" PHP cs fixer
let g:php_cs_fixer_path = "~/.config/composer/vendor/bin/php-cs-fixer"
let g:php_cs_fixer_rules = "@Symfony"
let g:php_cs_fixer_config_file = "~/.config/php_cs.dist"
let g:php_cs_fixer_php_path = "php"

if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
	let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*" --glob "!.svn/*" --glob "!vendor/*" --glob "!node_modules/*"'
endif

" Prettier
let g:prettier#autoformat = 0

let g:gutentags_cache_dir = '~/.config/nvim/tags'

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif"`'")"'")
