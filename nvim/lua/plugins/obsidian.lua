return {
  "epwalsh/obsidian.nvim",
  lazy = false,
  version = "*",  -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "cricut",
        path = "~/vaults/cricut",
      },
    },
    mappings = {
      n = {
        { "<Leader>o", desc = "Obsidian" },
        -- Open the vault
        { "<Leader>oo", "<cmd>ObsidianOpenVault<cr>", desc = "Open Obsidian Vault" },
        -- Open the current note
        { "<Leader>on", "<cmd>ObsidianOpenNote<cr>", desc = "Open Obsidian Note" },
        -- Create a new note
        { "<Leader>oc", "<cmd>ObsidianNewNote<cr>", desc = "New Obsidian Note" },
        -- Search in vault
        { "<Leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian Vault" },
      }
    },
  },
}
