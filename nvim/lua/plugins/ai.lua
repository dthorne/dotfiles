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
      -- provider = "ollama",
      -- model = "llama3-70b",
      provider = "copilot",
      copilot = {
        model = "claude-3.7-sonnet"
      },
      behaviour = {
        enable_cursor_planning_mode = true,
        enable_claude_text_edit_tool_mode = true,
      },
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
          return {
              require("mcphub.extensions.avante").mcp_tool(),
          }
      end,
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",   -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end
  }
}
