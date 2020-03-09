if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" php syntax
Plug 'StanAngeloff/php.vim'

" Auto completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Linter
Plug 'w0rp/ale'

" theme
Plug 'mhartington/oceanic-next'

" Git gutter
Plug 'mhinz/vim-signify'

" File Explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Statusbar
Plug 'itchyny/lightline.vim'

call plug#end()


syntax on " Get syntax
colorscheme OceanicNext
filetype plugin indent on
let mapleader = "\<Space>"
set number relativenumber " Show line number and relative numbers
set cmdheight=2 " Better display for messages
set updatetime=300 " Bad experience for diagnostic messages wit the default 4000
set encoding=utf-8
set hidden
set signcolumn=yes " Always draw sign column, stops jank
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set lazyredraw
set ttyfast
set vb t_vb= "No more beeps
set autoread
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set noswapfile

" Splits where i would expect them
set splitright
set splitbelow

" Make tab completion a bit more like bash
set wildmenu
set path+=**

" Keep 3 lines of context above/below the cursor rather than putting the
" cursor on the very top of the bottom line
set scrolloff=3

" Make tab appear 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Make netrw look better
let g:netrw_banner=0
let g:netrw_chgwin=1
let g:netrw_winsize=20

if (has("termguicolors"))
    set termguicolors
endif

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

" Double leader to switch between last two buffers
nnoremap <leader><leader> <c-^>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Map escape to something easier
inoremap jj <Esc>

" No arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Highlight trailing spaces
hi TrailingWhitespace ctermbg=red guibg=#f92672
:autocmd BufWinEnter * 2match TrailingWhitespace /\s\+$/

" File Indentation Settings per File Type
autocmd FileType html setlocal shiftwidth=4 tabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4
autocmd FileType vue setlocal shiftwidth=2 tabstop=2
autocmd FileType js setlocal shiftwidth=2 tabstop=2

" Permanent undo
set undodir=~/.vimdid
set undofile

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

" COC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Ale
let g:ale_fixers = {
\    '*': ['trim_whitespace'],
\}

let g:ale_php_phpcs_standard = '~/.config/nvim/phpcs-ruleset.xml'

" NERDtree
let NERDTreeShowHidden=1

nmap <leader>x :NERDTreeToggle<CR>

" If more than one window and previous buffer was NERDTree, go back to it.
"autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
