return {
  -- AI and such
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = true,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function() require("copilot_cmp").setup() end,
  },
  {
    "yetone/avante.nvim",
    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    build = "make",
    opts = {
      provider = "copilot",
      copilot = {
        model = "claude-3.7-sonnet"
      },
      behaviour = {
        enable_cursor_planning_mode = true,
        enable_claude_text_edit_tool_mode = true,
      },
    },
  },
}
