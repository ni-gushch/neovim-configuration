return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			enable_git_status = true,
			popup_border_style = "rounded",
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		})

		normal_map("<C-a>", ":Neotree source=filesystem reveal=true position=left<CR>", { desc = "Open NeoTree" })
		normal_map("<leader>tnt", ":Neotree toggle=true<CR>", { desc = "Toggle NeoTree" })
		normal_map("<leader>bf", ":Neotree buffers reveal float<CR>", { desc = "Open NeoTree oppened buffers" })
	end,
}
