return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "lua", "rust", "go", "gomod", "c_sharp",
          "markdown", "markdown_inline", "bash", "json", "toml", "yaml", "regex",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
