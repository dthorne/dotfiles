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
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>z :e ~/.zshrc<CR>
nnoremap <leader>gq :q<CR>
nnoremap <leader>ww :wa<CR>
imap jj <esc>:w<CR>
set nocompatible              " Eliminate vi backwards-compatability
set numberwidth=4             " The width of the number column
set number                    " Enable line numbers
set mouse=a
filetype off
filetype plugin indent on            " required!
syntax on                     " Syntax highlighting
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
set ignorecase
set wildmenu
set smartcase

silent !mkdir ~/.swap-files > /dev/null 2>&1
set swapfile
set dir=~/.swap-files

" copy (write) highlighted text to .vimbuffer
vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
" paste from buffer
map <leader><C-p> :r ~/.vimbuffer<CR>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Window navigation like Firefox.
set splitbelow
set splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <C-t>     <C-w>v 
noremap <C-s>   <C-w>s
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR><F9>
"Reloads vimrc after saving but keep cursor position
"
"
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
     let save_cursor = getcurpos()
     source $MYVIMRC
     call setpos('.', save_cursor)
   endfun
 endif
 autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()
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
    nnoremap <silent> <leader>f :Ag<CR>
    nnoremap <silent> <leader>a :Buffers<CR>
    nnoremap <silent> <leader>A :Windows<CR>
    nnoremap <silent> <leader>; :BLines<CR>
    nnoremap <silent> <leader>o :BTags<CR>
    nnoremap <silent> <leader>O :Tags<CR>
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>gl :Commits<CR>
    nnoremap <silent> <leader>ga :BCommits<CR>
    command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    Plug 'preservim/nerdtree' " nerdtree                  - File system browser (,e)
    map <C-p> :NERDTreeToggle<CR>
    map <leader>P :NERDTreeFind<CR>
    map <leader>p :NERDTreeFocus<CR>
    let NERDTreeShowHidden=1
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
    Plug 'pseewald/nerdtree-tagbar-combined'    " nerdtree-tagbar-combined  - Opens tagbar and NERDTree in one vertical split window
    Plug 'junegunn/vim-peekaboo'                " peekaboo                  - Shows the contents of the registers on a sidebar
    Plug 'kshenoy/vim-signature'                " signature                 - Show marks
    Plug 'preservim/tagbar'                    " tagbar                    - Show tags list (vars, funcs, etc.) (,t)
endif

"
" Git
"
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gi :Git wip<CR>
nnoremap <leader>gu :Git reset HEAD~1<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
Plug 'cedarbaum/fugitive-azure-devops'

Plug 'airblade/vim-gitgutter'

"
" Commands
"
if !exists('g:vscode')
    Plug 'henrik/vim-indexed-search'            " indexed-search            - Show N out of M in searches
endif
Plug 'scrooloose/nerdcommenter'             " nerdcommenter             - comment/uncomment source lines

Plug 'tpope/vim-repeat'                     " vim-repeat                - Repeats commands, including macros
Plug 'tpope/vim-speeddating'                " speeddating               - Use Ctrl+A and Ctrl+X in Vim editor to increase or decrease Date, Time, Roman Number and Ordinal Numbers.
Plug 'tpope/vim-unimpaired'                 " unimpaired                - mappings for pairs

Plug 'tpope/vim-abolish'                   " abolish                   - Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
Plug 'tpope/vim-surround'                  " surround                  - Add surround modifier to vim (s noun)
Plug 'justinmk/vim-sneak'                   " sneak                     - sneak around

"
" Code Completion
"
"Plug 'heavenshell/vim-jsdoc', { 
  "\ 'for': ['javascript', 'javascript.jsx','typescript', 'typescriptreact', 'typescript.tsx'], 
  "\ 'do': 'make install'}
"Plug 'alvan/vim-closetag'
" ================================================================
" vim-closetag
" ================================================================
" Update closetag to also work on js and html files, don't want ts since <> is used for type args
let g:closetag_filenames='*.html,*.js,*.jsx,*.tsx'
let g:closetag_regions = {
    \ 'typescript': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

Plug 'HerringtonDarkholme/yats'
"Plug 'leafgarland/typescript-vim'
"Plug 'Quramy/vim-js-pretty-template'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
"Plug 'peitalin/vim-jsx-typescript'
"Plug 'pangloss/vim-javascript'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"Plug 'Quramy/tsuquyomi'
Plug 'mattn/emmet-vim'
"Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandSnippetOrJump='<c-space>'
let g:UltiSnipsListSnippets='<leader><c-space>'

"Plug 'mlaursen/vim-react-snippets'
"Plug 'mlaursen/rmd-vim-snippets'
"
Plug 'meain/vim-package-info', { 'do': 'npm install' }


let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-styled-components',
  \ ]

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'

Plug 'github/copilot.vim'
imap <silent><script><expr> <leader><tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
nmap <silent> <M-k> <Plug>(copilot-previous)
nmap <silent> <M-j> <Plug>(copilot-next)
nmap <silent> <M-l> <Plug>(copilot-dismiss)

Plug 'metakirby5/codi.vim'
Plug 'diepm/vim-rest-console'
Plug 'vim-test/vim-test'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Coc-Jest commands
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>


" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
" Recently vim can merge signcolumn and number column into one
set signcolumn=number
else
set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : \<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ?  coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-n> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-m> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function!  s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
   execute '!' .  &keywordprg .  " .  expand('<cword>')
 endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename) 
" Formatting selected code.
xmap <leader>F <Plug>(coc-format-selected)
nmap <leader>F <Plug>(coc-format-selected)

" fix-it -- show preview window of fixable things and choose fix
nmap <silent>fi <Plug>(coc-codeaction)

" fix eslint (also any other fixable things. Mostly used for React hook dependencies)
nmap <silent>fe <Plug>(coc-fix-current)

" fix eslint (all)
nmap <silent>fE :<C-u>CocCommand eslint.executeAutofix<cr>

" fix imports
nmap <silent>fI :<C-u>CocCommand tsserver.organizeImports<cr>

" Show all diagnostics.
nnoremap <silent> <leader>d :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent> <leader>e :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>c :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>o :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>s :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent> <leader>r :<C-u>CocListResume<CR>
"
"
" Look and feel
"
Plug 'RRethy/vim-illuminate'                " illuminate                - hightlights other uses of word under cursor
Plug 'vim-airline/vim-airline'              " airline                   - statusline replacement
Plug 'vim-airline/vim-airline-themes'       " airline-themes            - additional airline themes
let g:airline_powerline_fonts = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
let g:airline#extensions#hunks#enabled=0
let g:airline_stl_path_style = 'short'
" remove the filetype part
let g:airline_section_x=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1
Plug 'flazz/vim-colorschemes'               " colorschemes              - a zillion colorschemes
Plug 'codehearts/mascara-vim'
Plug 'jimsei/winresizer'                    " winresizer                - Window resizing (,w)
Plug 'esneider/vim-simlight'                " simlight                  - Function and namespace highlighting

"
" Vim Extensions
"
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

"
" TESTING      
"
" Plug 'svermeulen/vim-easyclip'


call plug#end()

colorscheme codedark
highlight comment cterm=italic gui=italic
highlight keyword cterm=italic gui=italic
highlight identifier cterm=italic gui=italic
highlight special cterm=italic gui=italic
highlight type cterm=italic gui=italic
set noswapfile

set noshowmode  " to get rid of thing like --INSERT--
set shortmess+=F  " to get rid of the file name displayed in the command line bar

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
set t_ZH=^[[3m
set t_ZR=^[[23m
