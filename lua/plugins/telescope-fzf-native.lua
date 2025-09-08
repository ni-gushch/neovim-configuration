return {
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "make",
	config = function()
		pcall(function()
			require("telescope").load_extension("fzf")
		end)
	end,
}
