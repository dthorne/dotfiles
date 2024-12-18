-- ===================================================================
-- Dewey McNeill - vim settings
-- ===================================================================

-- ===================================================================
-- Key Mappings 
-- ===================================================================
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<space>', '<nop>', {noremap = true, silent = true})
-- Esc on jj  
vim.api.nvim_set_keymap('i', 'jj', '<esc>:w<CR>', {})
-- Stop search highlighting
vim.api.nvim_set_keymap('n', '<leader>h', ':noh<cr>', {noremap = true, silent = true})
-- Replace visual selection
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//g<left><left>', {noremap = true})

-- Config management
vim.api.nvim_create_user_command('Vimconfig', 'e $MYVIMRC', {bang = false})
vim.api.nvim_create_user_command('Zshconfig', 'e ~/dotfiles/zshrc', {bang = false})

--Reloads vimrc after saving but keep cursor position
function ReloadVimrc()
  local save_cursor = vim.fn.getcurpos()
  vim.cmd('source $MYVIMRC')
  vim.fn.setpos('.', save_cursor)
end
vim.api.nvim_create_user_command('ReloadVimrc', 'lua ReloadVimrc()', {bang = false})

-- ===================================================================
-- Editor settings
-- ===================================================================
vim.opt.numberwidth = 4
vim.opt.number = true
vim.opt.mouse = 'a'
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.wildmenu = true
vim.opt.smartcase = true
vim.cmd('silent !mkdir ~/.swap-files > /dev/null 2>&1')
vim.opt.swapfile = true
vim.opt.dir = '~/.swap-files'

-- ===================================================================
-- Window Management
-- ===================================================================
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})


-- ===================================================================
-- PLUGINS (packer settings - Package Manager)
-- ===================================================================

-- Install packer if we don't already have it
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
	use {
	  'junegunn/fzf.vim',
	  requires = { 'junegunn/fzf', run = ':call fzf#install()' }
	}

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>", -- set to `false` to disable one of the mappings
            node_incremental = "<CR>",
            node_decremental = "<BS>",
        },
      },
      })
    end,
  })

  use({
    'Wansmer/treesj',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end,
  })


  --
  -- UI Components
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
  vim.api.nvim_set_keymap('n', '<leader>gk', ':BCommits<CR>', {noremap = true, silent = true})
  --command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
  vim.cmd('command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {\'options\': \'--delimiter : --nth 4..\'}), <bang>0')

  --imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  vim.api.nvim_set_keymap('i', '<C-x><C-f>', '<plug>(fzf-complete-file-ag)', {})
  --imap <C-x><C-l> <plug>(fzf-complete-line)
  vim.api.nvim_set_keymap('i', '<C-x><C-l>', '<plug>(fzf-complete-line)', {})

  use { 
    "luukvbaal/nnn.nvim",
    config = function()
      require('nnn').setup({
        explorer = {
          width = 30, 
        },
        windownav = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
        }
      })
    end
  }

  vim.api.nvim_set_keymap('n', '<leader>n', ':NnnPicker<CR>', {noremap = true, silent = true})

  use { 'ryanoasis/vim-devicons'}
  vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {
    ['.*spec.*\\.ts$'] = 'ﬆ'
  }

  use { 'preservim/nerdtree'} -- nerdtree                  - File system browser (,e)
  --map <C-p> :ToggleNERDTree<CR>
  vim.api.nvim_set_keymap('n', '<C-p>', ':NERDTreeToggle<CR>', {noremap = true, silent = true})
  --map <leader>P :NERDTreeFind<CR>
  vim.api.nvim_set_keymap('n', '<leader>P', ':NERDTreeFind<CR>', {noremap = true, silent = true})
  --let NERDTreeShowHidden=1
  vim.g.NERDTreeShowHidden = 1
  use { 'Xuyuanp/nerdtree-git-plugin'}
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
  --autocmd StdinReadPre * let s:std_in=1
  vim.cmd('autocmd StdinReadPre * let s:std_in=1')
  --autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  vim.cmd('autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif')
  use { 'junegunn/vim-peekaboo'  }             -- peekaboo                  - Shows the contents of the registers on a sidebar
  use { 'kshenoy/vim-signature' }              -- signature                 - Show marks
  use { 'liuchengxu/vista.vim' }               -- vista                     - Code outline
  --use { 'preservim/tagbar'                   -- tagbar                    - Show tags list (vars, funcs, etc.) (,t)
  --use { 'pseewald/nerdtree-tagbar-combined'  -- nerdtree-tagbar-combined  - Opens tagbar and NERDTree in one vertical split window

  --
  -- Git
  --
  use { 'tpope/vim-fugitive'}
  use { 'tpope/vim-rhubarb'}
  --nnoremap <leader>gs :Git<CR>
  vim.api.nvim_set_keymap('n', '<leader>gs', ':Git ', {noremap = true, silent = true})
  --nnoremap <leader>gc :Gcommit -v -q<CR>

  use({
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })

  vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', {noremap = true, silent = true})
  

  use { 'junkblocker/git-time-lapse' }

  use { 'airblade/vim-gitgutter'}

  --
  -- Commands
  --
  use { 'henrik/vim-indexed-search'       }    -- indexed-search            - Show N out of M in searches
  use { 'scrooloose/nerdcommenter'       }     -- nerdcommenter             - comment/uncomment source lines

  use { 'tpope/vim-repeat'              }      -- vim-repeat                - Repeats commands, including macros
  use { 'tpope/vim-speeddating'        }       -- speeddating               - use Ctrl+A and Ctrl+X in Vim editor to increase or decrease Date, Time, Roman Number and Ordinal Numbers.
  use { 'tpope/vim-unimpaired'        }        -- unimpaired                - mappings for pairs

  use { 'tpope/vim-abolish'          }        -- abolish                   - Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
  use { 'tpope/vim-surround'        }         -- surround                  - Add surround modifier to vim (s noun)
  use {
    'ggandor/leap.nvim',
    config = function() require("leap").set_default_keymaps() end 
  }         -- leap.nvim                 - Jump to any character on the screen

  vim.g.closetag_filenames = '*.html,*.js,*.jsx,*.tsx'
  vim.g.closetag_regions = {
    typescript= 'jsxRegion',
    typescriptreact = 'jsxRegion,tsxRegion',
    ['typescript.tsx'] = 'jsxRegion,tsxRegion',
    ['javascript.jsx'] = 'jsxRegion',
    javascriptreact = 'jsxRegion',
  }

  use { 'HerringtonDarkholme/yats'}
  use { 'Shougo/vimproc.vim', run = 'make'}
  use { 'mattn/emmet-vim'}
  use { 'jasonwoodland/vim-html-indent' }
  use {
    "allaman/kustomize.nvim",
    requires = "nvim-lua/plenary.nvim",
    ft = "yaml",
    config = function()
      require('kustomize').setup()
    end,
  }
  vim.g.coc_global_extensions = {
    'coc-tsserver',
    'coc-eslint',
    'coc-styled-components',
  }

  use { 'neoclide/coc.nvim', branch = 'release'}
  use { 'antoinemadec/coc-fzf'}

  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-space>",
            accept_word = false,
            accept_line = false,
            next = "<M-j>",
            prev = "<M-k>",
            dismiss = "<C-m>",
          },
        },
        filetypes = {
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  }

  use {
    'CopilotC-Nvim/CopilotChat.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'zbirenbaum/copilot.lua',
    },
    run = 'make tiktoken',
    config = function()
      require('CopilotChat').setup({
        mappings = {

        }
      })
    end,
  }

  vim.api.nvim_set_keymap('n', '<leader>ai', ':CopilotChatToggle<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<leader>ai', ':CopilotChatExplain<CR>', {noremap = true, silent = true})

  use { 'metakirby5/codi.vim'}
  --Plug 'diepm/vim-rest-console'
  --use { 'vim-test/vim-test'
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
  -- use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  --nmap <silent> <C-n> <Plug>(coc-diagnostic-prev)
  --nmap <silent> <C-m> <Plug>(coc-diagnostic-next)
  vim.api.nvim_set_keymap('n', '<C-m>', '<Plug>(coc-diagnostic-next)', {})
  vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(coc-diagnostic-prev)', {})

  -- GoTo code navigation.
  --nmap <silent> gd <Plug>(coc-definition)
  vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
  --nmap <silent> gy <Plug>(coc-type-definition)
  vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
  --nmap <silent> gi <Plug>(coc-implementation)
  vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
  --nmap <silent> gr <Plug>(coc-references)
  vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

  function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
      else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
  end
  vim.api.nvim_set_keymap("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


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
  vim.api.nvim_set_keymap('n', '<leader>z', ':<C-u>CocList -I symbols<cr>', {noremap = true})
  -- Resume latest coc list.
  --nnoremap <silent> <leader>r :<C-u>CocListResume<CR>
  vim.api.nvim_set_keymap('n', '<leader>r', ':<C-u>CocListResume<CR>', {noremap = true})
  -- ==============================================================================
  -- Look and feel
  -- ==============================================================================
  use { 'RRethy/vim-illuminate'             }  -- illuminate                - hightlights other uses of word under cursor
  use {
    'nvim-lualine/lualine.nvim',
    config = function ()
      require('lualine').setup({
        sections = {
          lualine_b = {'branch'},
          lualine_x = {},
          lualine_y = {},
        }
      })
    end,
    requires = {
      'nvim-tree/nvim-web-devicons',
      opt = true,
    }
  }

  -- remove separators for empty sections
  --let g:airline_skip_empty_sections = 1
  --vim.g.airline_skip_empty_sections = 1

  use { 'flazz/vim-colorschemes' }             -- colorschemes              - a zillion colorschemes
  use {
    'daltonmenezes/aura-theme',
    rtp = 'packages/neovim',
    config = function()
      vim.cmd("colorscheme aura-soft-dark") -- Or any Aura theme available
    end
  }
  use { 'codehearts/mascara-vim'}
  use { 'jimsei/winresizer'     }              -- winresizer                - Window resizing (,w)
  use { 'esneider/vim-simlight' }              -- simlight                  - Function and namespace highlighting

  --
  -- Vim Extensions
  --
  use { 'xolox/vim-misc' }
  use { 'xolox/vim-session' }

  --vim.cmd('colorscheme codedark')
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
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
