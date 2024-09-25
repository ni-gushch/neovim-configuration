return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = { --[[ things you want to change go here]]
    },
    config = function()
      require("toggleterm").setup({})
      local terminal = require("toggleterm")

      vim.keymap.set("n", "<C-t>", terminal.toggle, { desc = "Open terminal window" })
      vim.keymap.set("t", "<C-t>", terminal.toggle, { desc = "Close terminal window" })
    end,
  },
}
