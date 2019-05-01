if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" theme
Plug 'mhartington/oceanic-next'

call plug#end()
