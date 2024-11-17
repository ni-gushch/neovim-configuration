return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				registries = {
					"file:~/programming/mason-registry",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "rust_analyzer", "gopls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local util = require("lspconfig/util")

			local lspconfig = require("lspconfig")
      lspconfig.taplo.setup({
        capabilities = capabilities,
      })
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			normal_map("K", vim.lsp.buf.hover, { desc = "Hover actions. Show info about object." })
			normal_map("<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			normal_map("<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
			normal_map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
		end,
	},
}
