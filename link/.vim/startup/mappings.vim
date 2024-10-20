" Unmap the arrow keys.
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" General mapping.
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>
map <C-S-Tab> :tabprevious<CR>
map <C-Tab> :tabnext<CR>
imap <C-S-Tab> <ESC>:tabprevious<CR>
imap <C-Tab> <ESC>:tabnext<CR>
"noremap <F7> :set expandtab!<CR>
nmap <Leader>h :tabnew %:h<CR>

" Default to very magic.
no / /\v

" NERDtree.
map <C-n> :NERDTreeToggle<CR>

" CtrlP.
nmap <Leader>r :CtrlPBufTag<CR>
