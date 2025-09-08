return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- prettier только для web-файлов
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "json", "css", "scss", "html", "yaml", "markdown" },
        }),
        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        -- C#
        null_ls.builtins.formatting.csharpier,
        -- Markdownlint
        null_ls.builtins.diagnostics.markdownlint,
        -- Buf (если реально используешь protobuf)
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.formatting.buf,
      },
    })

		normal_map("<leader>gf", vim.lsp.buf.format, { desc = "Format document" })
	end,
}
