-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:
---@type LazySpec
return {
  -- Plugin Overrides
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ",
        "░           ░   ░░░░   ░         ░░░░░░░░░░     ░░░░░        ░░░░░   ░      ░░░░░  ",
        "▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒   ▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒   ▒▒▒   ▒▒▒▒   ▒▒▒   ▒   ▒▒▒   ▒▒  ",
        "▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒   ▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒   ▒▒▒   ▒   ▒▒▒▒   ▒  ",
        "▓▓▓▓▓   ▓▓▓▓▓          ▓       ▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓  ▓   ▓▓▓▓▓▓▓   ▓   ▓▓▓▓   ▓  ",
        "▓▓▓▓▓   ▓▓▓▓▓   ▓▓▓▓   ▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓   ▓▓▓      ▓   ▓▓   ▓▓▓▓▓   ▓   ▓▓▓▓   ▓  ",
        "▓▓▓▓▓   ▓▓▓▓▓   ▓▓▓▓   ▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓  ▓▓▓   ▓▓▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓  ",
        "█████   █████   ████   █         █████████      █████   ██████   █   █      █████  ",
        "█████████████████████████████████████████████████████████████████████████████████  ",
      }
      return opts
    end,
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup {
        mappings = {
          i = {
            j = {
              k = false,
              j = "<Esc>:w<cr>",
            },
          },
          t = {
            j = {
              k = false,
              j = false,
            },
          },
        },
      }
    end,
  },
  -- Git Plugins
  { "junkblocker/git-time-lapse" },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    setup = function()
      require("lazygit").setup {
        auto_enable = true,
      }
      require("which-key").add {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      }
    end,
  },
  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup {
        mappings = {
        },
      }
      require('which-key').add {
        { "<leader>gh", group = "Octo" },
        { "<leader>ghr", "<cmd>Octo repo list<cr>", desc = "List Repositories" },
        { "<leader>ghp", "<cmd>Octo pr list<cr>",   desc = "List Pull Requests" },
        { "<leader>ghi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
        { "<leader>ghc", "<cmd>Octo pr checks<cr>", desc = "Check PR" },
        { "<leader>ghs", "<cmd>Octo pr review<cr>", desc = "Start Review" },
      }
    end,

  },
  -- Theme and UI
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
  -- {
  --   "baliestri/aura-theme",
  --   lazy = false,
  --   priority = 1000,
  --   config = function(plugin)
  --     vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
  --     vim.cmd [[colorscheme aura-soft-dark]]
  --   end,
  -- },
  { "jimsei/winresizer" },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup {
        use_default_keymaps = false,
      }
      local wk = require "which-key"
      wk.add {
        { "<leader>s",  group = "TreeSJ" },
        { "<leader>sm", '<cmd>lua require("treesj").toggle()<cr>', desc = "Toggle" },
        { "<leader>ss", '<cmd>lua require("treesj").split()<cr>',  desc = "Split" },
        { "<leader>sj", '<cmd>lua require("treesj").join()<cr>',   desc = "Join" },
      }
    end,
    cond = true,
  },
  -- Commands
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },
  { "henrik/vim-indexed-search" },          -- Show N out of M in searches

  { "tpope/vim-repeat",         cond = true }, -- Repeats commands, including macros
  { "tpope/vim-speeddating",    cond = true }, -- use Ctrl+A and Ctrl+X for Date, Time, Roman Number and Ordinal Numbers
  { "tpope/vim-unimpaired",     cond = true }, -- mappings for pairs

  { "tpope/vim-abolish",        cond = true }, -- Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
  { "tpope/vim-surround",       cond = true }, -- Add surround modifier to vim (s noun)
}
