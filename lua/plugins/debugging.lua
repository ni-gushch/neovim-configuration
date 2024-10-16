return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {

			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "cpptools" },
				automatic_installation = true,
			})
		end,
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			-- cpp c and rust debugger configuration
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}
			dap.adapters.lldb = {
				type = "executable",
				command = "~/.local/share/nvim/mason/packages/codelldb/extension/lldb/bin/lldb", -- adjust as needed
				name = "lldb",
			}

			-- dap ui opening configuration
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle dap ui interface" })
			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Debug continue" })
		end,
	},
}
