if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'itchyny/lightline.vim'
call plug#end()


set nocompatible
set autochdir

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set pastetoggle=<F3>

set background=dark
colorscheme palenight

set laststatus=2
if !has('gui_running')
	set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ }

if (has("termguicolors"))
set termguicolors
endif
