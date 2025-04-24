-- don't do anything in non-vscode instances
if not vim.g.vscode then return {} end

-- a list of known working plugins with vscode-neovim, update with your own plugins
local plugins = {
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "leap.nvim",
}

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return vim.tbl_contains(plugins, plugin.name) end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ff"] = "<CMD>Find<CR>",
          ["<Leader>fw"] = "<CMD>call VSCodeNotify('workbench.action.findInFiles')<CR>",
          ["<Leader>ls"] = "<CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
          ["<Leader>fo"] = "<CMD>call VSCodeNotify('workbench.action.recents')<CR>",
          -- File explorer toggle
          ["<Leader>e"] = "<CMD>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>",
          -- Go to definition (matches common IDE functionality)
          ["gd"] = "<CMD>call VSCodeNotify('editor.action.revealDefinition')<CR>",
          -- Show references
          ["gr"] = "<CMD>call VSCodeNotify('editor.action.goToReferences')<CR>",
                    -- close tab
          ["<Leader>q"] = "<CMD>call VSCodeNotify('workbench.action.closeActiveEditor', 0)<CR>",
          -- Rename symbol
          ["<Leader>lr"] = "<CMD>call VSCodeNotify('editor.action.rename')<CR>",
          -- Code actions
          ["<Leader>la"] = "<CMD>call VSCodeNotify('editor.action.quickFix')<CR>",
          -- Toggle terminal
          ["<Leader>tt"] = "<CMD>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>",
          -- Format document
          ["<Leader>lf"] = "<CMD>call VSCodeNotify('editor.action.formatDocument')<CR>",
          -- Show hover documentation
          ["K"] = "<CMD>call VSCodeNotify('editor.action.showHover')<CR>",
          -- Toggle comments (line or selection)
          ["<Leader>/"] = "<CMD>call VSCodeNotify('editor.action.commentLine')<CR>",
          -- Toggle problems panel
          ["<Leader>xx"] = "<CMD>call VSCodeNotify('workbench.actions.view.problems')<CR>",
          -- Navigate between problems/diagnostics
          ["[d"] = "<CMD>call VSCodeNotify('editor.action.marker.prev')<CR>",
          ["]d"] = "<CMD>call VSCodeNotify('editor.action.marker.next')<CR>",
          -- Quick open file by name
          ["<Leader>fp"] = "<CMD>call VSCodeNotify('workbench.action.quickOpen')<CR>",
          -- Navigate to implementation 
          ["gi"] = "<CMD>call VSCodeNotify('editor.action.goToImplementation')<CR>",
          -- Navigate to type definition
          ["gy"] = "<CMD>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>",
          -- Peek definition (show in-editor without navigating away)
          ["gD"] = "<CMD>call VSCodeNotify('editor.action.peekDefinition')<CR>",
          -- Toggle focus between editor and integrated terminal
          ["<Leader>tf"] = "<CMD>call VSCodeNotify('workbench.action.terminal.focus')<CR>",
          -- Open new terminal
          ["<Leader>tn"] = "<CMD>call VSCodeNotify('workbench.action.terminal.new')<CR>",
          -- Split editor vertically
          ["<Leader>\\"] = "<CMD>call VSCodeNotify('workbench.action.splitEditorOrthogonal')<CR>",
          -- Split editor horizontally
          ["<Leader>|"] = "<CMD>call VSCodeNotify('workbench.action.splitEditor')<CR>",
          -- Git commands
          ["<Leader>gl"] = "<CMD>call VSCodeNotify('git.viewHistory')<CR>",
          -- Open lazygit
          ["<Leader>gg"] = "<CMD>call VSCodeNotify('lazygit.openLazyGit')<CR>",
          -- Fold/unfold code
          ["zc"] = "<CMD>call VSCodeNotify('editor.fold')<CR>",
          ["zo"] = "<CMD>call VSCodeNotify('editor.unfold')<CR>",
          ["za"] = "<CMD>call VSCodeNotify('editor.toggleFold')<CR>",
          ["zM"] = "<CMD>call VSCodeNotify('editor.foldAll')<CR>",
          ["zR"] = "<CMD>call VSCodeNotify('editor.unfoldAll')<CR>",
          -- AI functionality keybindings (Copilot/GitHub CoPilot Chat)
          -- Similar to avante.nvim keybindings
          ["<Leader>aa"] = "<CMD>call VSCodeNotify('editor.action.inlineSuggest.trigger')<CR>",
          ["<Leader>af"] = "<CMD>call VSCodeNotify('workbench.action.quickchat.toggle')<CR>",
        },
        v = {
          -- Apply AI actions to visual selections
          ["<Leader>aa"] = "<CMD>call VSCodeNotify('github.copilot.interactiveEditor.explain')<CR>",
          ["<Leader>ae"] = "<CMD>call VSCodeNotify('github.copilot.interactiveEditor.generateInline')<CR>",
          ["<Leader>af"] = "<CMD>call VSCodeNotify('github.copilot.interactiveEditor.fix')<CR>",
          ["<Leader>at"] = "<CMD>call VSCodeNotify('github.copilot.chat.askAppendSelectedToEditor')<CR>",
        },
      },
    },
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
