" General Settings
set dict=/usr/share/dict/words
set cursorline
set showcmd
set ruler
set incsearch
set wildmenu
syntax enable
set synmaxcol=0
set term=screen-256color
set display=uhex
set shortmess=aAIsT
set cmdheight=2
set nowrap
if &diff
	set wrap
endif
let &scrolloff=999-&scrolloff
set smartcase

set completeopt=menu
set mousemodel=popup
set backspace=2
set number
set nocompatible

set enc=utf-8
set fillchars=vert:¦

set noexpandtab
set tabstop=4
set shiftwidth=4
set foldcolumn=1
set cc=+1,+2

set linespace=0
set history=1000
set list listchars=tab:› ,trail:-,extends:>,precedes:<,eol:¬

set laststatus=2
set ffs=unix
set mouse=a
set vb
set ttym=xterm2

set wrap

let mapleader='\'

set noswapfile

" CtrlP
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher.
if executable('ag')
	" Use ag in CtrlP for listing files. Lightning fast and respects
	" .gitignore.
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" Ag is fast enough that CtrlP doesn't need to cache.
	let g:ctrlp_use_caching = 0
endif

" NERDTree
let NERDTreeShowHidden=1
