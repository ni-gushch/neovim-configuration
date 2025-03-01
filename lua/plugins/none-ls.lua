return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.goimports_reviser,
				null_ls.builtins.formatting.golines,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.formatting.buf
				-- null_ls.builtins.diagnostics.eslint_d,
			},
		})

		normal_map("<leader>gf", vim.lsp.buf.format, { desc = "Format document" })
	end,
}
