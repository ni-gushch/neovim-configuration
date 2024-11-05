return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_registry = require("mason-registry")
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
			local cfg = require("rustaceanvim.config")

			vim.g.rustaceanvim = function()
				return {
					-- Plugin configuration
					tools = {},
					-- LSP configuration
					server = {
						-- on_attach = vim.g.rustaceanvim.server.on_attach,
						on_attach = function(_, bufnr)
              -- you can also put keymaps in here
              -- stylua: ignore start
              print("we here in rust config")
              normal_map(
                "<leader>ca", function() vim.cmd.RustLsp("codeAction") end,
                { silent = true, buffer = bufnr }
              )
              normal_map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end)
              normal_map(
                "<leader>e", function() vim.cmd.RustLsp({ 'explainError', 'cycle' }) end,
                { desc = "Open [F]loating [D]iagnostic message" }
              )
              normal_map("<leader>df", function() vim.cmd.RustLsp("explainError") end)
							-- stylua: ignore stop
						end,
						default_settings = {
							-- rust-analyzer language server configuration
							["rust-analyzer"] = {
								cargo = {
									allFeatures = true,
									loadOutDirsFromCheck = true,
									buildScripts = {
										enable = true,
									},
								},
							},
							-- Add clippy lints for Rust
							checkOnSave = true,
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
					-- DAP configuration
					dap = {
						adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
					},
				}
			end
		end,
	},
}
