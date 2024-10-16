return {
  {
    'nvim-telescope/telescope-ui-select.nvim'
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          }
        }
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', "<C-p>", builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', "<leader><leader>", builtin.oldfiles, { desc = "Show old files" })

      require("telescope").load_extension("ui-select")
    end
  }
}
