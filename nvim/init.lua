-- ===================================================================
-- Dewey McNeill - vim settings
-- ===================================================================
--
-- Check if running in VSCode Neovim extension
local is_vscode = vim.g.vscode == 1 
-- ===================================================================
-- Key Mappings 
-- ===================================================================
require('mappings');

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
require('set');

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
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installation = { "vtsls", "eslint", "lua", "angular-language-server" },
        automatic_installation = true
      })
    end
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

  -- ===================================================================
  -- fzf setup
  -- ===================================================================
	use {
	  'junegunn/fzf.vim',
	  requires = { 'junegunn/fzf', run = ':call fzf#install()' }
	}

  vim.g.fzf_nvim_statusline = 0

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

  -- ===================================================================
  -- File Sidebar (NERDTree)
  -- ===================================================================

  use { 'ryanoasis/vim-devicons'}
  vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {
    ['.*spec.*\\.ts$'] = 'ﬆ'
  }

  use { 'preservim/nerdtree' } -- nerdtree                  - File system browser (,e)
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

  use { 'junegunn/vim-peekaboo' }             -- peekaboo                  - Shows the contents of the registers on a sidebar
  vim.g.peekaboo_window = 'vertical botright 50new'

  use { 'kshenoy/vim-signature' }              -- signature                 - Show and navigate to marks m<letter> m<space> `]
  use { 'liuchengxu/vista.vim' }               -- vista                     - Code outline

  --
  -- Git
  --
  use { 'tpope/vim-fugitive'} -- fugitive                  - Git integration
  use { 'tpope/vim-rhubarb'} -- rhubarb                   - Fugitive-companion to interact with github
  use { 'junkblocker/git-time-lapse' } -- git-time-lapse             - Git time lapse
  use { 'airblade/vim-gitgutter'}

  use({
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })

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

  use { 'Shougo/vimproc.vim', run = 'make' }
  use { 'mattn/emmet-vim' }

  -- ===================================================================
  -- Language Server Protocol
  -- ===================================================================

  use {
    'hrsh7th/cmp-nvim-lsp',
    after = { 'nvim-cmp', 'nvim-lspconfig' },
    config = function()
    end
  }
  use {
    'hrsh7th/cmp-buffer',
    after = { 'nvim-cmp' },
  }
  use {
    'hrsh7th/cmp-path',
    after = { 'nvim-cmp' },
  }
  use {
    'hrsh7th/cmp-cmdline',
    after = { 'nvim-cmp' },
  }
  use {
    'hrsh7th/nvim-cmp',
    after = { 'copilot-cmp' },
    config = function() 
      local cmp = require('cmp');
      require('cmp').setup({
        preselect = cmp.PreselectMode.None,
        window = {
          completion = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<esc>'] = cmp.mapping.close({ select = false }),
          ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<CR>'] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.config.disable,
          }),
          ['<C-space>'] = cmp.mapping.complete(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'copilot' },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            return vim_item
          end
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        },{
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end
  }

  -- ===================================================================
  -- Language Server Protocol LSP
  -- ===================================================================
  use {
    'neovim/nvim-lspconfig',
    config = function()
      --local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local function on_attach(client, bufnr)
        -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "v", "<C-k>", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>s", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>', opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", '<cmd>lua vim.lsp.buf.format()<CR>', opts)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
        vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.format()', {bang = false})
      end
      require('lspconfig').vtsls.setup({
        --capabilities = capabilities,
        on_attach = on_attach
      })
      require('lspconfig').angularls.setup({
        --capabilities = capabilities,
        on_attach = on_attach
      })
      require('lspconfig').eslint.setup({
        on_attach
      })
      require('lspconfig').lua.setup({
        on_attach
      })
    end
  }

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
          enabled = false,
        },
        suggestion = {
          enabled = false,
        },
       copilot_node_command = 'node', -- Node.js version must be > 16.x
      })
    end,
  }

  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
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

  -- ===================================================================
  -- Misc Tools
  -- ===================================================================
  use { 'metakirby5/codi.vim' }
  use { 'diepm/vim-rest-console' }
  use { 'vim-test/vim-test' }


  -- ===================================================================
  -- More NVIM settings
  -- ===================================================================


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
  if not is_vscode
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
end
  -- Italics
  --vim.cmd('let &t_ZH="e[3m"')
  --vim.cmd('let &t_ZR="e[23m"')
  --vim.cmd('set t_ZH=^[[3m')
  --vim.cmd('set t_ZR=^[[23m')
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
