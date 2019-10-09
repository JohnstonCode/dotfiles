if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" comment out lines
Plug 'tpope/vim-commentary'

" theme
Plug 'mhartington/oceanic-next'

" Git stuff
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Auto insert pairs
Plug 'jiangmiao/auto-pairs'

" php syntax
Plug 'StanAngeloff/php.vim'

" Linter
Plug 'w0rp/ale'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

" PHP
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

" PHP use sorter
Plug 'arnaud-lb/vim-php-namespace'

" File Explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=                       " Custom status line
set statusline+=%#PmenuSel#           " Show git branch if it exists
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f                  " Show file name
set statusline+=%m\                   " Show whether file has been modified
set statusline+=%=                    " Right align the following
set statusline+=%#CursorColumn#
set statusline+=\ %y                  " Filetype
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " File encoding
set statusline+=\ [%{&fileformat}\]    " File format
set statusline+=\ %p%%                " Percentage through file
set statusline+=\ %l:%c               " Line number:Column number
set statusline+=\                     " End

" vim doesnt play well with other shells
set shell=/bin/bash

" Allow switching to other buffers without saving
set hidden

" Dont scatter swap files throughout the filesystem
set directory=/tmp//

" wait 100ms instead of 1sec for keycode sequences
set ttimeoutlen=100

" Show partially typed commands in the status bar
set showcmd

" Get some decent auto-indenting
filetype plugin indent on

" Delete comment character when joining commented lines
set formatoptions+=j

" User persistent undo. Opening a file that has previously been edited
" restores its undo history
set undofile
set undodir=/tmp

" Dont hide lines that are too long to display in the window - show as much as
" possible
set display=lastline

" Make tab completion a bit more like bash
set wildmenu
set path+=**

" Keep 3 lines of context above/below the cursor rather than putting the
" cursor on the very top of the bottom line
set scrolloff=3

" Show hybrid line numbers
set number relativenumber

" Make tab appear 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Always show sign column so errors dont move page
set signcolumn=yes

" Make search better
set ignorecase
set smartcase

" Make delete behave like other editors
set backspace=indent,eol,start

set autoread

" Make netrw look better
let g:netrw_banner=0
let g:netrw_chgwin=1
let g:netrw_winsize=20

" Theme
if (has("termguicolors"))
    set termguicolors
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

syntax enable
colorscheme OceanicNext


" Map escape to something easier
inoremap jk <Esc>
inoremap kj <Esc>

" Common caps errors
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" No arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Double leader to switch between last two buffers
nnoremap <leader><leader> <c-^>

" Set normal split defaults
set splitright
set splitbelow


" Plugin conf

" Ale
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay=1000
let g:ale_php_phpstan_level=7
let g:ale_php_phpstan_executable='vendor/bin/phpstan'
let g:al_echo_msg_format='[%linter%] %s [%severity%]'

let g:ale_fixers = {
\    '*': ['trim_whitespace'],
\    'javascript': ['prettier'],
\    'css': ['prettier'],
\    'php': ['php_cs_fixer'],
\}

let g:ale_linters = {
\    'php': ['phpstan'],
\}


" Fzf
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let $FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!vendor/*" --glob "!node_modules/*"'
else
    echom "rg is not installed!"
endif

nnoremap <leader>b :Buffer<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>s :Rg<CR>

" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use tab to trigger completion ahead and navigate.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Phpactor
" Invoke the context menu
nmap <leader>mm :call phpactor#ContextMenu()<CR>

" Transform the class in the current file
nmap <leader>tt :call phpactor#Transform()<CR>

" Include use statement
nmap <leader>u :call phpactor#UseAdd()<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Temp fix till neovim has floating windows show signature in cmd bar
set cmdheight=2
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


" Php namespace
let g:php_namespace_sort = "'{,'}-1!awk '{print length, $0}' | sort -n -s | cut -d' ' -f2-"

" Sort use statements
nmap <leader>su :call PhpSortUse()<CR>

" nerdtree
nmap <leader>x :NERDTreeToggle<CR>

" Highlight trailing spaces
hi TrailingWhitespace ctermbg=red guibg=#f92672
:autocmd BufWinEnter * 2match TrailingWhitespace /\s\+$/

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Source vim configuration upon save
augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END
