-- ===================================================================
-- Dewey McNeill - vim settings
-- ===================================================================

-- ===================================================================
-- Basic settings that need to be done early.
-- ===================================================================
--
-- Key Mappings 
--
vim.g.mapleader = ' '
--nnoremap <space> <nop>
vim.api.nvim_set_keymap('n', '<space>', '<nop>', {noremap = true, silent = true})
--nnoremap <leader>v :e $MYVIMRC<CR>
vim.api.nvim_set_keymap('n', '<leader>v', ':e $MYVIMRC<CR>', {noremap = true})
--nnoremap <leader>z :e ~/.zshrc<CR>
vim.api.nvim_set_keymap('n', '<leader>z', ':e ~/.zshrc<CR>', {noremap = true})
--nnoremap <leader>gq :q<CR>
vim.api.nvim_set_keymap('n', '<leader>gq', ':q<CR>', {noremap = true})
--nnoremap <leader>ww :wa<CR>
vim.api.nvim_set_keymap('n', '<leader>ww', ':wa<CR>', {noremap = true})
--imap jj <esc>:w<CR>
vim.api.nvim_set_keymap('i', 'jj', '<esc>:w<CR>', {})
--set numberwidth=4            -- The width of the number column
vim.opt.numberwidth = 4
--set number                   -- Enable line numbers
vim.opt.number = true
--set mouse=a
vim.opt.mouse = 'a'
--filetype off
vim.cmd('filetype off')
--filetype plugin indent on           -- required!
vim.cmd('filetype plugin indent on')
--syntax on                     --Syntax highlighting
vim.cmd('syntax on')
-- On pressing tab, insert 2 spaces
--set expandtab
vim.opt.expandtab = true
-- show existing tab with 2 spaces width
--set tabstop=2
vim.opt.tabstop = 2
--set softtabstop=2
vim.opt.softtabstop = 2
-- when indenting with '>', use 2 spaces width
--set shiftwidth=2
vim.opt.shiftwidth = 2
--set ignorecase
vim.opt.ignorecase = true
--set wildmenu
vim.opt.wildmenu = true
--set smartcase
vim.opt.smartcase = true

--silent !mkdir ~/.swap-files > /dev/null 2>&1
vim.cmd('silent !mkdir ~/.swap-files > /dev/null 2>&1')
--set swapfile
vim.opt.swapfile = true
--set dir=~/.swap-files
vim.opt.dir = '~/.swap-files'

-- Disable highlight when <leader><cr> is pressed
--map <silent> <leader><cr> :noh<cr>
vim.api.nvim_set_keymap('n', '<leader><cr>', ':noh<cr>', {noremap = true, silent = true})
-- Replace visual selection
--vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//g<left><left>', {noremap = true})


-- ===================================================================
-- Window Management
-- ===================================================================
--set splitbelow
vim.opt.splitbelow = true
--set splitright
vim.opt.splitright = true
--nnoremap <C-h> <C-w>h
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
--nnoremap <C-j> <C-w>j
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
--nnoremap <C-k> <C-w>k
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
--nnoremap <C-l> <C-w>l
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})
--Reloads vimrc after saving but keep cursor position
function ReloadVimrc()
  local save_cursor = vim.fn.getcurpos()
  vim.cmd('source $MYVIMRC')
  vim.fn.setpos('.', save_cursor)
end
vim.cmd('autocmd! BufWritePost $MYVIMRC call ReloadVimrc()')

-- ===================================================================
-- Session Management
-- ===================================================================
--function! MakeSession()
  --let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  --if (filewritable(b:sessiondir) != 2)
    --exe 'silent !mkdir -p ' b:sessiondir
    --redraw!
  --endif
  --let b:filename = b:sessiondir . '/session.vim'
  --exe "mksession! " . b:filename
--endfunction
--function MakeSession()
  --local b_sessiondir = vim.fn.expand('$HOME') .. '/.vim/sessions' .. vim.fn.getcwd()
  --if (vim.fn.filewritable(b_sessiondir) ~= 2) then
    --vim.cmd('silent !mkdir -p ' .. b_sessiondir)
    --vim.cmd('redraw!')
  --end
  --local b_filename = b_sessiondir .. '/session.vim'
  --vim.cmd('mksession! ' .. b_filename)
--end

--function! LoadSession()
  --let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  --let b:sessionfile = b:sessiondir . "/session.vim"
  --if (filereadable(b:sessionfile))
    --exe 'source ' b:sessionfile
  --else
    --echo "No session loaded."
  --endif
--endfunction
--function LoadSession()
  --local b_sessiondir = vim.fn.expand('$HOME') .. '/.vim/sessions' .. vim.fn.getcwd()
  --local b_sessionfile = b_sessiondir .. '/session.vim'
  --if (vim.fn.filereadable(b_sessionfile)) then
    --vim.cmd('source ' .. b_sessionfile)
  --else
    --vim.cmd('echo "No session loaded."')
  --end
--end

-- Adding automatons for when entering or leaving Vim
--au VimEnter * nested :call LoadSession()
--au VimLeave * :call MakeSession()
-- ===================================================================
-- PLUGINS (vim-plug settings - Package Manager)
-- ===================================================================

-- Install vim-plug if we don't already have it
--if empty(glob("~/.config/nvim/autoload/plug.vim"))
   ---- Ensure all needed directories exist  (Thanks @kapadiamush)
    --execute '!mkdir -p ~/.config/nvim/plugged'
    --execute '!mkdir -p ~/.config/nvim/autoload'
   ---- Download the actual plugin manager
    --execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
--endif
--call plug#begin()
if vim.fn.empty(vim.fn.glob('~/.config/nvim/autoload/plug.vim')) > 0 then
  vim.fn.system({'mkdir', '-p', '~/.config/nvim/plugged'})
  vim.fn.system({'mkdir', '-p', '~/.config/nvim/autoload'})
  vim.fn.system({'curl', '-fLo', '~/.config/nvim/autoload/plug.vim', 'https://raw.github.com/junegunn/vim-plug/master/plug.vim'})
end
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

--
-- UI Components
--Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug ('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug 'junegunn/fzf.vim'
--let g:fzf_nvim_statusline = 0 -- disable statusline overwriting
vim.g.fzf_nvim_statusline = 0
--nnoremap <silent> <leader><space> :Files<CR>
vim.api.nvim_set_keymap('n', '<leader><space>', ':Files<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>f :Ag<CR>
vim.api.nvim_set_keymap('n', '<leader>f', ':Ag<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>a :Buffers<CR>
vim.api.nvim_set_keymap('n', '<leader>a', ':Buffers<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>A :Windows<CR>
vim.api.nvim_set_keymap('n', '<leader>A', ':Windows<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>; :BLines<CR>
vim.api.nvim_set_keymap('n', '<leader>;', ':BLines<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>o :BTags<CR>
vim.api.nvim_set_keymap('n', '<leader>o', ':BTags<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>O :Tags<CR>
vim.api.nvim_set_keymap('n', '<leader>O', ':Tags<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>? :History<CR>
vim.api.nvim_set_keymap('n', '<leader>?', ':History<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>gl :Commits<CR>
vim.api.nvim_set_keymap('n', '<leader>gl', ':Commits<CR>', {noremap = true, silent = true})
--nnoremap <silent> <leader>ga :BCommits<CR>
vim.api.nvim_set_keymap('n', '<leader>ga', ':BCommits<CR>', {noremap = true, silent = true})
--command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
vim.cmd('command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {\'options\': \'--delimiter : --nth 4..\'}), <bang>0')

--imap <C-x><C-f> <plug>(fzf-complete-file-ag)
vim.api.nvim_set_keymap('i', '<C-x><C-f>', '<plug>(fzf-complete-file-ag)', {})
--imap <C-x><C-l> <plug>(fzf-complete-line)
vim.api.nvim_set_keymap('i', '<C-x><C-l>', '<plug>(fzf-complete-line)', {})

Plug 'preservim/nerdtree' -- nerdtree                  - File system browser (,e)
--map <C-p> :ToggleNERDTree<CR>
vim.api.nvim_set_keymap('n', '<C-p>', ':NERDTreeToggle<CR>', {noremap = true, silent = true})
--map <leader>P :NERDTreeFind<CR>
vim.api.nvim_set_keymap('n', '<leader>P', ':NERDTreeFind<CR>', {noremap = true, silent = true})
--let NERDTreeShowHidden=1
vim.g.NERDTreeShowHidden = 1
Plug 'Xuyuanp/nerdtree-git-plugin'
-- nerdtree-git-plugin 
 --let g:NERDTreeGitStatusIndicatorMapCustom = {
vim.g.NERDTreeGitStatusIndicatorMapCustom = {
  Modified  = "✹",
  Staged    = "✚",
  Untracked = "✭",
  Renamed   = "➜",
  Unmerged  = "═",
  Deleted   = "✖",
  Dirty     = "✗",
  Clean     = "✔︎",
  Ignored   = '☒',
  Unknown   = "?"
}
Plug 'ryanoasis/vim-devicons'
--autocmd StdinReadPre * let s:std_in=1
vim.cmd('autocmd StdinReadPre * let s:std_in=1')
--autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
vim.cmd('autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif')
Plug 'junegunn/vim-peekaboo'               -- peekaboo                  - Shows the contents of the registers on a sidebar
Plug 'kshenoy/vim-signature'               -- signature                 - Show marks
Plug 'liuchengxu/vista.vim'                -- vista                     - Code outline
--Plug 'preservim/tagbar'                   -- tagbar                    - Show tags list (vars, funcs, etc.) (,t)
--Plug 'pseewald/nerdtree-tagbar-combined'  -- nerdtree-tagbar-combined  - Opens tagbar and NERDTree in one vertical split window

--
-- Git
--
Plug 'tpope/vim-fugitive'
--nnoremap <leader>gs :Git<CR>
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {noremap = true, silent = true})
--nnoremap <leader>gc :Gcommit -v -q<CR>
vim.api.nvim_set_keymap('n', '<leader>gc', ':Gcommit -v -q<CR>', {noremap = true, silent = true})
--nnoremap <leader>ga :Gcommit --amend<CR>
vim.api.nvim_set_keymap('n', '<leader>ga', ':Gcommit --amend<CR>', {noremap = true, silent = true})
--nnoremap <leader>gt :Gcommit -v -q %<CR>
vim.api.nvim_set_keymap('n', '<leader>gt', ':Gcommit -v -q %<CR>', {noremap = true, silent = true})
--nnoremap <leader>gi :Git wip<CR>
vim.api.nvim_set_keymap('n', '<leader>gi', ':Git wip<CR>', {noremap = true, silent = true})
--nnoremap <leader>gu :Git reset HEAD~1<CR>
vim.api.nvim_set_keymap('n', '<leader>gu', ':Git reset HEAD~1<CR>', {noremap = true, silent = true})
--nnoremap <leader>gd :Gdiff<CR>
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', {noremap = true, silent = true})
--nnoremap <leader>gl :Glog<CR>
vim.api.nvim_set_keymap('n', '<leader>gl', ':Glog<CR>', {noremap = true, silent = true})
--nnoremap <leader>gp :Ggrep<Space>
vim.api.nvim_set_keymap('n', '<leader>gp', ':Ggrep<Space>', {noremap = true, silent = true})
--nnoremap <leader>gb :Git branch<Space>
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git branch<Space>', {noremap = true, silent = true})
--nnoremap <leader>go :Git checkout<Space>
vim.api.nvim_set_keymap('n', '<leader>go', ':Git checkout<Space>', {noremap = true, silent = true})
--nnoremap <leader>gpl :Dispatch! git pull<CR>
vim.api.nvim_set_keymap('n', '<leader>gpl', ':Dispatch! git pull<CR>', {noremap = true, silent = true})
Plug 'cedarbaum/fugitive-azure-devops'

Plug 'airblade/vim-gitgutter'

--
-- Commands
--
Plug 'henrik/vim-indexed-search'           -- indexed-search            - Show N out of M in searches
Plug 'scrooloose/nerdcommenter'            -- nerdcommenter             - comment/uncomment source lines

Plug 'tpope/vim-repeat'                    -- vim-repeat                - Repeats commands, including macros
Plug 'tpope/vim-speeddating'               -- speeddating               - Use Ctrl+A and Ctrl+X in Vim editor to increase or decrease Date, Time, Roman Number and Ordinal Numbers.
Plug 'tpope/vim-unimpaired'                -- unimpaired                - mappings for pairs

Plug 'tpope/vim-abolish'                  -- abolish                   - Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
Plug 'tpope/vim-surround'                 -- surround                  - Add surround modifier to vim (s noun)
Plug 'justinmk/vim-sneak'                  -- sneak                     - sneak around

--Plug 'heavenshell/vim-jsdoc', { 
  --"\ 'for': ['javascript', 'javascript.jsx','typescript', 'typescriptreact', 'typescript.tsx'], 
  --"\ 'do': 'make install'}
--Plug 'alvan/vim-closetag'
-- ================================================================
-- vim-closetag
-- ================================================================
-- Update closetag to also work on js and html files, don't want ts since <> is used for type args
--let g:closetag_filenames='*.html,*.js,*.jsx,*.tsx'
vim.g.closetag_filenames = '*.html,*.js,*.jsx,*.tsx'
--let g:closetag_regions = {
vim.g.closetag_regions = {
  typescript= 'jsxRegion',
  typescriptreact = 'jsxRegion,tsxRegion',
  ['typescript.tsx'] = 'jsxRegion,tsxRegion',
  ['javascript.jsx'] = 'jsxRegion',
  javascriptreact = 'jsxRegion',
}

Plug 'HerringtonDarkholme/yats'
Plug ('Shougo/vimproc.vim', {['do'] = 'make'})
Plug 'mattn/emmet-vim'
--Plug 'SirVer/ultisnips'
--let g:UltiSnipsExpandSnippetOrJump='<c-space>'
--let g:UltiSnipsListSnippets='<leader><c-space>'

--Plug 'mlaursen/vim-react-snippets'
--Plug 'mlaursen/rmd-vim-snippets'

--let g:coc_global_extensions = [
vim.g.coc_global_extensions = {
  'coc-tsserver',
  'coc-eslint',
  'coc-styled-components',
}

Plug ('neoclide/coc.nvim', {['branch'] = 'release'})
Plug 'antoinemadec/coc-fzf'

--Plug 'github/copilot.vim'
----imap <silent><script><expr> <c-space> copilot#Accept("\<CR>")
----vim.api.nvim_set_keymap('i', '<c-space>', vim.fn['copilot#Accept']('<CR>'), {})
----let g:copilot_no_tab_map = v:true 
--vim.g.copilot_no_tab_map = true
----nmap <silent> <M-k> <Plug>(copilot-previous)
--vim.api.nvim_set_keymap('n', '<M-k>', '<Plug>(copilot-previous)', {})
----nmap <silent> <M-j> <Plug>(copilot-next)
--vim.api.nvim_set_keymap('n', '<M-j>', '<Plug>(copilot-next)', {})
----nmap <silent> <M-l> <Plug>(copilot-dismiss)
Plug 'zbirenbaum/copilot.lua'

Plug 'metakirby5/codi.vim'
--Plug 'diepm/vim-rest-console'
--Plug 'vim-test/vim-test'
--nmap <silent> t<C-n> :TestNearest<CR>
--nmap <silent> t<C-f> :TestFile<CR>
--nmap <silent> t<C-s> :TestSuite<CR>
--nmap <silent> t<C-l> :TestLast<CR>
--nmap <silent> t<C-g> :TestVisit<CR>

-- Coc-Jest commands
--nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>


-- TextEdit might fail if hidden is not set.
--set hidden

-- Give more space for displaying messages.
--set cmdheight=3
vim.o.cmdheight = 3

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
--set updatetime=300
vim.o.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
--set shortmess+=c
--vim.o.shortmess = vim.o.shortmess .. 'c'

--set signcolumn=number
vim.o.signcolumn = 'number'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        vim.fn["coc#refresh"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<C-h>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
--inoremap <silent><expr> <cr> pumvisible() ?  coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
vim.api.nvim_set_keymap('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"', {expr = true})
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
--nmap <silent> <C-n> <Plug>(coc-diagnostic-prev)
--nmap <silent> <C-m> <Plug>(coc-diagnostic-next)

-- GoTo code navigation.
--nmap <silent> gd <Plug>(coc-definition)
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
--nmap <silent> gy <Plug>(coc-type-definition)
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
--nmap <silent> gi <Plug>(coc-implementation)
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
--nmap <silent> gr <Plug>(coc-references)
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

_G.show_documentation = function() 
  if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.fn['coc#rpc#ready']() then
    vim.fn.CocActionAsync('doHover')
  else
    vim.cmd('!' .. vim.o.keywordprg .. ' ' .. vim.fn.expand('<cword>'))
  end
end
-- Use K to show documentation in preview window.
--nnoremap <silent> K :call <SID>show_documentation()<CR>
--vim.api.nvim_set_keymap('n', 'K', ':call <SID>show_documentation()<CR>')
vim.api.nvim_set_keymap('n', 'K', 'v:lua.show_documentation()', {noremap = true, expr = true})


--function!  s:show_documentation()
  --if (index(['vim','help'], &filetype) >= 0)
    --execute 'h '.expand('<cword>')
  --elseif (coc#rpc#ready())
    --call CocActionAsync('doHover')
  --else
   --execute '!' .  &keywordprg .  " .  expand('<cword>')
 --endif
--endfunction

-- Highlight the symbol and its references when holding the cursor.
--autocmd CursorHold * silent call CocActionAsync('highlight')
vim.cmd('autocmd CursorHold * silent call CocActionAsync("highlight")')
-- Symbol renaming.
--nmap <leader>rn <Plug>(coc-rename) 
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})
-- Formatting selected code.
--xmap <leader>F <Plug>(coc-format-selected)
vim.api.nvim_set_keymap('x', '<leader>F', '<Plug>(coc-format-selected)', {})
--nmap <leader>F <Plug>(coc-format-selected)
vim.api.nvim_set_keymap('n', '<leader>F', '<Plug>(coc-format-selected)', {})

-- fix-it -- show preview window of fixable things and choose fix
--nmap <silent>fi <Plug>(coc-codeaction)
vim.api.nvim_set_keymap('n', 'fi', '<Plug>(coc-codeaction)', {})

-- fix eslint (also any other fixable things. Mostly used for React hook dependencies)
--nmap <silent>fe <Plug>(coc-fix-current)
vim.api.nvim_set_keymap('n', 'fe', '<Plug>(coc-fix-current)', {})

-- fix eslint (all)
--nmap <silent>fE :<C-u>CocCommand eslint.executeAutofix<cr>
vim.api.nvim_set_keymap('n', 'fE', ':<C-u>CocCommand eslint.executeAutofix<cr>', {})

-- Show all diagnostics.
--nnoremap <silent> <leader>d :<C-u>CocList diagnostics<cr>
vim.api.nvim_set_keymap('n', '<leader>d', ':<C-u>CocList diagnostics<cr>', {noremap = true})
-- Manage extensions.
--nnoremap <silent> <leader>e :<C-u>CocList extensions<cr>
vim.api.nvim_set_keymap('n', '<leader>e', ':<C-u>CocList extensions<cr>', {noremap = true})
-- Show commands.
--nnoremap <silent> <leader>c :<C-u>CocList commands<cr>
vim.api.nvim_set_keymap('n', '<leader>c', ':<C-u>CocList commands<cr>', {noremap = true})
-- Find symbol of current document.
--nnoremap <silent> <leader>o :<C-u>CocList outline<cr>
vim.api.nvim_set_keymap('n', '<leader>o', ':<C-u>CocList outline<cr>', {noremap = true})
-- Search workspace symbols.
--nnoremap <silent> <leader>s :<C-u>CocList -I symbols<cr>
vim.api.nvim_set_keymap('n', '<leader>s', ':<C-u>CocList -I symbols<cr>', {noremap = true})
-- Resume latest coc list.
--nnoremap <silent> <leader>r :<C-u>CocListResume<CR>
vim.api.nvim_set_keymap('n', '<leader>r', ':<C-u>CocListResume<CR>', {noremap = true})
-- ==============================================================================
-- Look and feel
-- ==============================================================================
Plug 'RRethy/vim-illuminate'               -- illuminate                - hightlights other uses of word under cursor
Plug 'vim-airline/vim-airline'             -- airline                   - statusline replacement
Plug 'vim-airline/vim-airline-themes'      -- airline-themes            - additional airline themes
--let g:airline_powerline_fonts = 1
vim.g.airline_powerline_fonts = 1
--let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
vim.g['airlineparts#ffenc#skip_expected_string']='utf-8[unix]'
--let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
vim.g['airline#parts#ffenc#skip_expected_string']='utf-8[dos]'
--let g:airline#extensions#hunks#enabled=0
vim.g['airline#extensions#hunks#enabled']=0
--let g:airline_stl_path_style = 'short'
vim.g.airline_stl_path_style = 'short'
-- remove the filetype part
--let g:airline_section_x=''
vim.g.airline_section_x=''
-- remove separators for empty sections
--let g:airline_skip_empty_sections = 1
vim.g.airline_skip_empty_sections = 1

Plug 'flazz/vim-colorschemes'              -- colorschemes              - a zillion colorschemes
Plug 'codehearts/mascara-vim'
Plug 'jimsei/winresizer'                   -- winresizer                - Window resizing (,w)
Plug 'esneider/vim-simlight'               -- simlight                  - Function and namespace highlighting

--
-- Vim Extensions
--
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

--call plug#end()
vim.cmd('call plug#end()')

vim.cmd('colorscheme codedark')
vim.cmd('highlight comment cterm=italic gui=italic')
vim.cmd('highlight keyword cterm=italic gui=italic')
vim.cmd('highlight identifier cterm=italic gui=italic')
vim.cmd('highlight special cterm=italic gui=italic')
vim.cmd('highlight type cterm=italic gui=italic')
vim.cmd('set noswapfile')
-- to get rid of thing like --INSERT--

vim.cmd('set noshowmode')
vim.cmd('autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact')
vim.cmd('autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart')
vim.cmd('autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear')
-- Italics
vim.cmd('let &t_ZH="e[3m"')
vim.cmd('let &t_ZR="e[23m"')
vim.cmd('set t_ZH=^[[3m')
vim.cmd('set t_ZR=^[[23m')
