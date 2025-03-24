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
        " ███████╗██╗  ██╗██╗   ██╗ ██████╗██╗   ██╗██╗ ██████╗██╗  ██╗",
        " ██╔════╝██║  ██║██║   ██║██╔════╝██║   ██║██║██╔════╝██║ ██╔╝",
        " ███████╗███████║██║   ██║██║     ██║   ██║██║██║     █████╔╝ ",
        " ╚════██║██╔══██║██║   ██║██║     ██║   ██║██║██║     ██╔═██╗ ",
        " ███████║██║  ██║╚██████╔╝╚██████╗╚██████╔╝██║╚██████╗██║  ██╗",
        " ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝",
        " ",
        "    ███████╗██╗  ██╗██╗   ██╗ ██████╗██╗   ██╗██╗ ██████╗██╗  ██╗",
        "    ██╔════╝██║  ██║██║   ██║██╔════╝██║   ██║██║██╔════╝██║ ██╔╝",
        "    ███████╗███████║██║   ██║██║     ██║   ██║██║██║     █████╔╝ ",
        "    ╚════██║██╔══██║██║   ██║██║     ██║   ██║██║██║     ██╔═██╗ ",
        "    ███████║██║  ██║╚██████╔╝╚██████╗╚██████╔╝██║╚██████╗██║  ██╗",
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
              j = "<Esc>:w<cr>",
            },
          },
        },
      }
    end,
  },
  -- Git Plugins
  { "junkblocker/git-time-lapse" },

  -- Theme and UI
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd [[colorscheme aura-soft-dark]]
    end,
  },
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
        { "<leader>s", group = "TreeSJ" },
        { "<leader>sm", '<cmd>lua require("treesj").toggle()<cr>', desc = "Toggle" },
        { "<leader>ss", '<cmd>lua require("treesj").split()<cr>', desc = "Split" },
        { "<leader>sj", '<cmd>lua require("treesj").join()<cr>', desc = "Join" },
      }
    end,
  },
  -- Commands
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },
  { "henrik/vim-indexed-search" }, -- Show N out of M in searches
  { "scrooloose/nerdcommenter" }, -- comment/uncomment source lines

  { "tpope/vim-repeat" }, -- Repeats commands, including macros
  { "tpope/vim-speeddating" }, -- use Ctrl+A and Ctrl+X for Date, Time, Roman Number and Ordinal Numbers
  { "tpope/vim-unimpaired" }, -- mappings for pairs

  { "tpope/vim-abolish" }, -- Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
  { "tpope/vim-surround" }, -- Add surround modifier to vim (s noun)
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
}
