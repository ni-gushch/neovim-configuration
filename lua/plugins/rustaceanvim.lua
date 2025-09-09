return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local adapter = nil
			local ok, mason_registry = pcall(require, "mason-registry")

			-- Безопасная проверка наличия и установки codelldb
			if ok then
				-- Проверяем, установлен ли codelldb
				local codelldb_installed = mason_registry.is_installed("codelldb")
				local codelldb_available = mason_registry.has_package("codelldb")

				if codelldb_installed and codelldb_available then
					local codelldb = mason_registry.get_package("codelldb")
					if codelldb then
						local path_to_package = "$MASON/packages/" .. codelldb.name
						local install_path = vim.fn.expand(path_to_package)
						local extension_path = install_path .. "/extension/"
						local codelldb_path = extension_path .. "adapter/codelldb"
						local liblldb_path = ""

						if vim.loop.os_uname().sysname:find("Windows") then
							liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
						elseif vim.fn.has("mac") == 1 then
							liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
						else
							liblldb_path = extension_path .. "lldb/lib/liblldb.so"
						end

						-- Проверяем существование файлов перед созданием adapter
						if vim.fn.filereadable(codelldb_path) == 1 and vim.fn.filereadable(liblldb_path) == 1 then
							adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
						else
							vim.notify(
								"codelldb files not found. Please reinstall codelldb via Mason",
								vim.log.levels.WARN
							)
						end
					end
				else
					vim.notify("codelldb not installed. Run :MasonInstall codelldb", vim.log.levels.INFO)
				end
			end

			vim.g.rustaceanvim = {
				tools = {
					-- Настройки инструментов
				},
				server = {
					on_attach = function(client, bufnr)
						-- Базовые keymaps для LSP
						local opts = { buffer = bufnr, remap = false }

						custom_map("n", "K", vim.lsp.buf.hover, opts)
						custom_map("n", "gd", vim.lsp.buf.definition, opts)
						custom_map("n", "gD", vim.lsp.buf.declaration, opts)
						custom_map("n", "gi", vim.lsp.buf.implementation, opts)
						custom_map("n", "go", vim.lsp.buf.type_definition, opts)
						custom_map("n", "gr", vim.lsp.buf.references, opts)
						custom_map("n", "gs", vim.lsp.buf.signature_help, opts)
						custom_map("n", "<F2>", vim.lsp.buf.rename, opts)
						custom_map("n", "<F4>", vim.lsp.buf.code_action, opts)
						custom_map("n", "gl", vim.diagnostic.open_float, opts)
						custom_map("n", "[d", vim.diagnostic.goto_prev, opts)
						custom_map("n", "]d", vim.diagnostic.goto_next, opts)

						-- Специфичные для Rust keymaps
						custom_map("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr })
						custom_map("n", "<leader>e", function()
							vim.cmd.RustLsp({ "explainError", "cycle" })
						end, { buffer = bufnr, desc = "Explain error" })
						custom_map("n", "<leader>df", function()
							vim.cmd.RustLsp("explainError")
						end, { buffer = bufnr, desc = "Show diagnostic" })
					end,
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							checkOnSave = {
								enable = true,
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
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
				},
				dap = adapter and { adapter = adapter } or nil,
			}
		end,
	},
}
