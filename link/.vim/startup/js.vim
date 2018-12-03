autocmd FileType javascript noremap <F4> :silent exe "s/\\v^(\\s*)(.+)$/\\1\\2\r\\1console.log(" . expand('<cword>') . ", '" . expand('<cword>') . "');"<CR>

" vim-syntastic
let g:syntastic_javascript_checkers = ['eslint']
