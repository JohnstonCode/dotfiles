if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" theme
Plug 'mhartington/oceanic-next'

" VCS gutter
Plug 'mhinz/vim-signify'

" Auto insert pairs
Plug 'jiangmiao/auto-pairs'

" php syntax
Plug 'StanAngeloff/php.vim'

" Linter
Plug 'w0rp/ale'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" PHP
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

call plug#end()
