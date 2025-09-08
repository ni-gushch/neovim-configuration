vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    pcall(function() vim.lsp.buf.format({ async = false }) end)
  end,
})

local ft = vim.api.nvim_create_augroup("FiletypeIndent", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = ft,
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = ft,
  pattern = { "rust" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})


