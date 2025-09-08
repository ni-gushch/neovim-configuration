return {
	"ray-x/go.nvim",
	ft = { "go", "gomod", "gowork", "gotmpl" },
	dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
	opts = {
		lsp_cfg = true,
		lsp_inlay_hints = { enable = true },
		dap_debug = true,
		test_runner = "go",
	},
}
