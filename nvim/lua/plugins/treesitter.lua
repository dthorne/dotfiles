---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "typescript",
      "html",
      "css",
      "json",
      "yaml",
      "markdown",
    },
  },
}
