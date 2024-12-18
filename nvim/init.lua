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

  -- ===================================================================
  -- fzf setup
  -- ===================================================================
	use {
	  'junegunn/fzf.vim',
	  requires = { 'junegunn/fzf', run = ':call fzf#install()' }
	}

  vim.g.fzf_nvim_statusline = 0
  vim.api.nvim_set_keymap('n', '<leader><space>', ':Files<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>f', ':Ag<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>a', ':Buffers<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>A', ':Windows<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>o', ':BTags<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>O', ':Tags<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>?', ':History<CR>', {noremap = true, silent = true})
  --vim.api.nvim_create_user_command('Ag', 'call fzf#vim#ag(<q-args>, {\'options\': \'--delimiter : --nth 4..\'}), <bang>0', {bang = true, nargs = '*'})

  vim.api.nvim_set_keymap('i', '<C-x><C-f>', '<plug>(fzf-complete-file-ag)', {})
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

  -- ===================================================================
  -- File Sidebar (NERDTree)
  -- ===================================================================

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

  use { 'junegunn/vim-peekaboo'  }             -- peekaboo                  - Shows the contents of the registers on a sidebar
  vim.g.peekaboo_window = 'vertical botright 50new'

  use { 'kshenoy/vim-signature' }              -- signature                 - Show and navigate to marks m<letter> m<space> `]
  use { 'liuchengxu/vista.vim' }               -- vista                     - Code outline
  --use { 'preservim/tagbar'                   -- tagbar                    - Show tags list (vars, funcs, etc.) (,t)
  --use { 'pseewald/nerdtree-tagbar-combined'  -- nerdtree-tagbar-combined  - Opens tagbar and NERDTree in one vertical split window

  --
  -- Git
  --
  use { 'tpope/vim-fugitive'} -- fugitive                  - Git integration
  use { 'tpope/vim-rhubarb'} -- rhubarb                   - Fugitive-companion to interact with github
  use { 'junkblocker/git-time-lapse' } -- git-time-lapse             - Git time lapse
  use { 'airblade/vim-gitgutter'}
  vim.api.nvim_set_keymap('n', '<leader>gs', ':Git ', {noremap = true, silent = true})

  use({
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })

  vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', {noremap = true, silent = true})



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

  --use { 'HerringtonDarkholme/yats'}
  use { 'Shougo/vimproc.vim', run = 'make' }
  use { 'mattn/emmet-vim' }

  -- ===================================================================
  -- Language Server Protocol
  -- ===================================================================
  vim.g.coc_global_extensions = {
    'coc-tsserver',
    'coc-eslint',
    'coc-styled-components',
  }
  use { 'neoclide/coc.nvim', branch = 'release'}
  use { 'antoinemadec/coc-fzf'}


  -- ===================================================================
  -- AI Tooling
  -- ===================================================================
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

  -- ===================================================================
  -- Misc Tools
  -- ===================================================================
  use { 'metakirby5/codi.vim' }
  use { 'diepm/vim-rest-console' }
  use { 'vim-test/vim-test' }


  -- ===================================================================
  -- More NVIM settings
  -- ===================================================================
  vim.o.cmdheight = 3
  vim.o.updatetime = 300
  vim.o.signcolumn = 'number'

  -- ===================================================================
  -- CoC tab completion
  -- ===================================================================
  -- Make <CR> auto-select the first completion item and notify coc.nvim to
  -- format on enter, <cr> could be remapped by other vim plugin
  vim.api.nvim_set_keymap('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "<CR>"', {noremap = false, expr = true})
  -- use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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

  -- Highlight the symbol and its references when holding the cursor.
  --autocmd CursorHold * silent call CocActionAsync('highlight')
  vim.cmd('autocmd CursorHold * silent call CocActionAsync("highlight")')
  -- Symbol renaming.
  vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})
  -- Formatting selected code.
  vim.api.nvim_set_keymap('x', '<leader>F', '<Plug>(coc-format-selected)', {})
  vim.api.nvim_set_keymap('n', '<leader>F', '<Plug>(coc-format-selected)', {})
  -- fix-it -- show preview window of fixable things and choose fix
  vim.api.nvim_set_keymap('n', 'fi', '<Plug>(coc-codeaction)', {})
  -- fix eslint (also any other fixable things. Mostly used for React hook dependencies)
  vim.api.nvim_set_keymap('n', 'fe', '<Plug>(coc-fix-current)', {})
  -- fix eslint (all)
  vim.api.nvim_set_keymap('n', 'fE', ':<C-u>CocCommand eslint.executeAutofix<cr>', {})
  -- Show all diagnostics.
  vim.api.nvim_set_keymap('n', '<leader>d', ':<C-u>CocList diagnostics<cr>', {noremap = true})
  -- Manage extensions.
  vim.api.nvim_set_keymap('n', '<leader>e', ':<C-u>CocList extensions<cr>', {noremap = true})
  -- Show commands.
  vim.api.nvim_set_keymap('n', '<leader>c', ':<C-u>CocList commands<cr>', {noremap = true})
  -- Find symbol of current document.
  vim.api.nvim_set_keymap('n', '<leader>o', ':<C-u>CocList outline<cr>', {noremap = true})
  -- Search workspace symbols.
  vim.api.nvim_set_keymap('n', '<leader>z', ':<C-u>CocList -I symbols<cr>', {noremap = true})
  -- Resume latest coc list.
  vim.api.nvim_set_keymap('n', '<leader>r', ':<C-u>CocListResume<CR>', {noremap = true})
  -- ==============================================================================
  -- Look and feel
  -- ==============================================================================
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

  use { 'flazz/vim-colorschemes' }             -- colorschemes              - a zillion colorschemes
  use {
    'daltonmenezes/aura-theme',
    rtp = 'packages/neovim',
    config = function()
      vim.cmd("colorscheme aura-soft-dark") -- Or any Aura theme available
    end
  }
  use { 'codehearts/mascara-vim'}             -- mascara-vim               - Enable italics for Dank Mono
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
