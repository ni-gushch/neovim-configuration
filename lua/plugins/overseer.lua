return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin" },
  },
  config = function(_, opts)
    require("overseer").setup(opts)
    normal_map("<leader>tr", "<cmd>OverseerRun<CR>", { desc = "Run task" })
    normal_map("<leader>tt", "<cmd>OverseerToggle<CR>", { desc = "Tasks" })
  end,
}

