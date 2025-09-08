return {
  { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown" }, opts = { enabled = true } },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    ft = { "markdown" },
    opts = {
      servers = { marksman = {} },
    },
  },
}
