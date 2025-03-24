return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "zbirenbaum/copilot-cmp",
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    opts.preselect = cmp.PreselectMode.None
    opts.mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<esc>"] = cmp.mapping.close(),
      ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      ["<CR>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm { select = true },
        c = cmp.config.disable,
      },
      ["<C-space>"] = cmp.mapping.complete(),
    }
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "copilot", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    }
    opts.formatting = {
      format = function(entry, vim_item)
        vim_item.menu = entry:get_completion_item().detail
        return vim_item
      end,
    }
  end,
}
