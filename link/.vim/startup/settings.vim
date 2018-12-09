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

set tags=~/.vim/tags/tags

if version > 720
	set undofile
	set undodir=~/vimundo/
endif

let mapleader='\'
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set noswapfile

"let g:Powerline_symbols = 'fancy'
"call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ["<C-n>"]
let g:ycm_key_list_previous_completion = ["<C-p>"]
let g:SuperTabDefaultCompletionType = "<C-n>"

" Better key bindings for UltiSnipsExandTrigger 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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

" vim-syntastic
let g:syntastic_php_checkers = ['php']

autocmd FileType vim noremap <F5> :s/^/"/<CR>
autocmd FileType vim noremap <F6> :s/^"//<CR>

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
