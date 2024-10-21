" Pathogen.
"
" To disable a plugin, add it's bundle name to the following list
" let g:pathogen_disabled = ["vim-snippets"]
call pathogen#infect()

" Filetypes.
filetype plugin on
filetype indent on

" Load custom settings.
source ~/.vim/startup/color.vim
source ~/.vim/startup/haskell.vim
source ~/.vim/startup/dart.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/settings.vim
