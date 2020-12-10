" ===================================================================
" Dewey McNeill - vim settings
" ===================================================================

" ===================================================================
" Basic settings that need to be done early.
" ===================================================================
"
" Key Mappings 
"
let mapleader = ' '
nnoremap <space> <nop>
imap jj <esc>
set nocompatible              " Eliminate vi backwards-compatability
set numberwidth=4             " The width of the number column
set number                    " Enable line numbers
filetype plugin on            " required!
filetype indent on            " required!
syntax on                     " Syntax highlighting
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

silent !mkdir ~/.swap-files > /dev/null 2>&1
set swapfile
set dir=~/.swap-files

" Window navigation like Firefox.
set splitbelow
set splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <C-t>     <C-w>s 
noremap <C-S-t>   <C-w>v
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR><F9>

" ===================================================================
" PLUGINS (vim-plug settings - Package Manager)
" ===================================================================

" Install vim-plug if we don't already have it
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    " Ensure all needed directories exist  (Thanks @kapadiamush)
    execute '!mkdir -p ~/.config/nvim/plugged'
    execute '!mkdir -p ~/.config/nvim/autoload'
    " Download the actual plugin manager
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin()

"
" UI Components
if !exists('g:vscode')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    let g:fzf_nvim_statusline = 0 " disable statusline overwriting
    nnoremap <silent> <leader><space> :Files<CR>
    nnoremap <silent> <leader>a :Buffers<CR>
    nnoremap <silent> <leader>A :Windows<CR>
    nnoremap <silent> <leader>; :BLines<CR>
    nnoremap <silent> <leader>o :BTags<CR>
    nnoremap <silent> <leader>O :Tags<CR>
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>gl :Commits<CR>
    nnoremap <silent> <leader>ga :BCommits<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)
    Plug 'preservim/nerdtree' " nerdtree                  - File system browser (,e)
    map <C-p> :NERDTreeToggle<CR>
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " nerdtree-git-plugin 
     let g:NERDTreeGitStatusIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
    Plug 'ryanoasis/vim-devicons'
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    "Plug 'pseewald/nerdtree-tagbar-combined'    " nerdtree-tagbar-combined  - Opens tagbar and NERDTree in one vertical split window
    Plug 'junegunn/vim-peekaboo'                " peekaboo                  - Shows the contents of the registers on a sidebar
    Plug 'kshenoy/vim-signature'                " signature                 - Show marks
    Plug 'majutsushi/tagbar'                    " tagbar                    - Show tags list (vars, funcs, etc.) (,t)
endif

"
" Git
"
Plug 'tpope/vim-fugitive'

"
" Commands
"
if !exists('g:vscode')
    Plug 'henrik/vim-indexed-search'            " indexed-search            - Show N out of M in searches
    Plug 'terryma/vim-multiple-cursors'        " multiple-cursors          - Multiple cursors (next: Ctrl-N, prev: Ctrl-P, skip: Ctrl-X)
endif
Plug 'scrooloose/nerdcommenter'             " nerdcommenter             - comment/uncomment source lines

Plug 'tpope/vim-repeat'                     " vim-repeat                - Repeats commands, including macros
Plug 'tpope/vim-speeddating'                " speeddating               - Use Ctrl+A and Ctrl+X in Vim editor to increase or decrease Date, Time, Roman Number and Ordinal Numbers.
Plug 'tpope/vim-unimpaired'                 " unimpaired                - mappings for pairs

Plug 'tpope/vim-abolish'                   " abolish                   - Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
Plug 'tpope/vim-surround'                  " surround                  - Add surround modifier to vim (s noun)

"
" Code Completion
"
if !exists('g:vscode')
    Plug 'leafgarland/typescript-vim'
    Plug 'Quramy/vim-js-pretty-template'
    Plug 'pangloss/vim-javascript'
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'Quramy/tsuquyomi'
endif


"
" Language specific
"
Plug 'OmniSharp/omnisharp-vim'
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
nnoremap <C-o><C-u> :OmniSharpFindUsages<CR>
nnoremap <C-o><C-d> :OmniSharpGotoDefinition<CR>
nnoremap <C-o><C-d><C-p> :OmniSharpPreviewDefinition<CR>
nnoremap <C-o><C-r> :!dotnet.exe run

"
" Look and feel
"
Plug 'RRethy/vim-illuminate'                " illuminate                - hightlights other uses of word under cursor
Plug 'vim-airline/vim-airline'              " airline                   - statusline replacement
Plug 'vim-airline/vim-airline-themes'       " airline-themes            - additional airline themes
Plug 'flazz/vim-colorschemes'               " colorschemes              - a zillion colorschemes
Plug 'jimsei/winresizer'                    " winresizer                - Window resizing (,w)
Plug 'esneider/vim-simlight'                " simlight                  - Function and namespace highlighting

"
" Vim Extensions
"
" Plug 'her/central.vim'                      " central.vim               - local backups

"
" TESTING      
"
" Plug 'svermeulen/vim-easyclip'


call plug#end()

if !exists('g:vscode')
    autocmd FileType typescript JsPreTmpl html
    autocmd FileType typescript syn clear foldBraces
endif

set noshowmode  " to get rid of thing like --INSERT--
set shortmess+=F  " to get rid of the file name displayed in the command line bar
