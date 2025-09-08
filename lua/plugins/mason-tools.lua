return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      -- LSP
      "rust_analyzer", "gopls", "csharp-language-server", "marksman", "lua-language-server", "taplo",
      -- DAP
      "codelldb", "delve", "netcoredbg",
      -- Formatters/Linters
      "rustfmt", "clippy",
      "gofumpt", "goimports-reviser", "golines",
      "csharpier",
      "markdownlint",
    },
    run_on_start = true,
  },
}
