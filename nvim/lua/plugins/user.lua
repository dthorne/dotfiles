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
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    keys = {
      -- Global Octo commands available everywhere
      { "<leader>gh", group = "Octo" },
      { "<leader>ghr", "<cmd>Octo repo list<cr>", desc = "List Repositories" },
      { "<leader>ghp", "<cmd>Octo pr list<cr>", desc = "List Pull Requests" },
    },
    config = function()
      require("octo").setup {}
      -- Filetype-specific keybindings only available in Octo buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "octo",
        callback = function()
          local wk = require "which-key"
          wk.add({
            { "<leader>ghc", "<cmd>Octo pr checks<cr>", desc = "Check PR" },
            { "<leader>ghs", "<cmd>Octo review start<cr>", desc = "Start Review" },
            { "<leader>gho", "<cmd>Octo pr browser<cr>", desc = "Open PR in browser" },
            { "<localleader>a", group = "Assignees" },
            { "<localleader>c", group = "Comments" },
            { "<localleader>i", group = "Close/Reopen" },
            { "<localleader>l", group = "Labels" },
            { "<localleader>p", group = "Changes" },
            { "<localleader>r", group = "Reactions" },
            { "<localleader>v", group = "Review"}
          }, { buffer = 0 }) -- '0' targets the current buffer
          -- For autocomplete on usernames
          vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
        end,
      })
      -- Filetype-specific keybindings only available in Octo buffers
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname:match "OctoChangedFiles" then
            -- Define your custom keybindings here
            local wk = require "which-key"
            wk.add {
              { "<localleader>a", proxy = "<localleader><space>]q", desc = "mark and next" },
            }
          end
        end,
      })
    end,
  },
  -- gitlinker
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>ghy", "<cmd>GitLink<cr>", desc = "Get Repo URL" },
      { "<leader>ghb", "<cmd>GitLink!<cr>", desc = "Browse Current Line" },
    },
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
      if vim.g.vscode then
        -- Direct keybindings without which-key for VSCode
        vim.keymap.set("n", "<leader>sm", '<cmd>lua require("treesj").toggle()<cr>', { desc = "Toggle" })
        vim.keymap.set("n", "<leader>ss", '<cmd>lua require("treesj").split()<cr>', { desc = "Split" })
        vim.keymap.set("n", "<leader>sj", '<cmd>lua require("treesj").join()<cr>', { desc = "Join" })
      else
        local wk = require "which-key"
        wk.add {
          { "<leader>s", group = "TreeSJ" },
          { "<leader>sm", '<cmd>lua require("treesj").toggle()<cr>', desc = "Toggle" },
          { "<leader>ss", '<cmd>lua require("treesj").split()<cr>', desc = "Split" },
          { "<leader>sj", '<cmd>lua require("treesj").join()<cr>', desc = "Join" },
        }
      end
    end,
    cond = true,
  },
  -- Commands
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },
  { "henrik/vim-indexed-search" }, -- Show N out of M in searches

  { "tpope/vim-repeat", cond = true }, -- Repeats commands, including macros
  { "tpope/vim-speeddating", cond = true }, -- use Ctrl+A and Ctrl+X for Date, Time, Roman Number and Ordinal Numbers
  { "tpope/vim-unimpaired", cond = true }, -- mappings for pairs

  { "tpope/vim-abolish", cond = true }, -- Change case (crs: snake_case, crm: MixedCase, crc: camelCase, cru: UPPER_CASE)
  { "tpope/vim-surround", cond = true }, -- Add surround modifier to vim (s noun)
}
