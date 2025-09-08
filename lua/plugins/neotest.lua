return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		-- adapters:
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"Issafalcon/neotest-dotnet",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go")({ experimental = { test_table = true } }),
				require("neotest-rust")({ args = { "--nocapture" } }),
				require("neotest-dotnet")({
					discovery_root = "solution", -- auto-detect .sln; можно убрать опцию
				}),
			},
			quickfix = { enabled = false },
			output = { open_on_run = "short" },
			summary = { open = "botright vsplit | vertical resize 50" },
		})
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
		end
		map("<leader>tn", function()
			neotest.run.run()
		end, "Test nearest")
		map("<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, "Test file")
		map("<leader>tp", function()
			neotest.run.run(vim.loop.cwd())
		end, "Test project")
		map("<leader>to", function()
			neotest.output.open({ enter = true })
		end, "Open output")
		map("<leader>ts", function()
			neotest.summary.toggle()
		end, "Toggle summary")
	end,
}
