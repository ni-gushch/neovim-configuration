normal_map = function(keys, func, additional_args)
  additional_args = additional_args or {}
  vim.keymap.set("n", keys, func, additional_args)
end

custom_map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
