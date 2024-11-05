return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    require('nvim-tmux-navigation').setup({})
    normal_map("<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
    normal_map("<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
    normal_map("<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
    normal_map("<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
  end,
}
