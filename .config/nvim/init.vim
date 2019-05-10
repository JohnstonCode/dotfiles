source ~/.config/nvim/plugins.vim

set number relativenumber " Show hybrid line numbers
set tabstop=4 " Make tab appear 4 spaces
set shiftwidth=4
set signcolumn=yes

" netrw config
let g:netrw_banner = 0
let g:netrw_chgwin= -1
let g:netrw_winsize = 20


" THEME
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme OceanicNext

" KEY MAPPINGS

" map escape to something easier
inoremap jk <Esc>
inoremap kj <Esc>

" common caps errors
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Include use statement
nmap <Leader>pu :call phpactor#UseAdd()<CR>
nmap <Leader>pt :call phpactor#Transform()<CR>

" PLUGIN CONF

" ALE
let g:ale_linters = {
\   'php': ['phpstan', 'phpmd', 'php'],
\}

let g:ale_lint_delay = 1000
let g:ale_php_phpstan_level = 4
let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" FZF
if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
	let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*" --glob "!.svn/*" --glob "!vendor/*" --glob "!node_modules/*"'
endif

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>s :Rg<CR>

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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
