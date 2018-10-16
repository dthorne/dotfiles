call plug#begin('/Users/deweymcneill/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
call plug#end()

syntax enable 
autocmd BufNewFile,BufRead *.json set ft=javascript
"set background=dark
if &diff
  colorscheme evening
endif
set number
set t_Co=256
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set laststatus=2
let &t_SI = "\<Esc>]50;CursorShape=1\x7" 
let &t_EI = "\<Esc>]50;CursorShape=0\x7" 
