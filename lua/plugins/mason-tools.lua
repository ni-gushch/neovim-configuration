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
      "rust-analyzer", "gopls", "csharp-language-server", "marksman", "typescript-language-server", "lua-language-server", "taplo", -- + ltex-ls (опц.)
      -- DAP
      "codelldb", "delve", "netcoredbg", "cpptools",
      -- Formatters/Linters
      "rustfmt", 
      -- "clippy", NotFound?
      "gofumpt", "goimports-reviser", "golines",
      "csharpier",
      "markdownlint",
      -- Прочее по списку из README (buf и т.п.) если нужно:
      "buf",
    },
    run_on_start = true,
  },
}
