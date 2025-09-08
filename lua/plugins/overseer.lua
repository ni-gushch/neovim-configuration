return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin" },
  },
  config = function(_, opts)
    require("overseer").setup(opts)
    local map = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true }) end
    map("<leader>tr", "<cmd>OverseerRun<CR>", "Run task")
    map("<leader>tt", "<cmd>OverseerToggle<CR>", "Tasks")
  end,
}
