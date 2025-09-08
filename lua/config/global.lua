normal_map = function(keys, func, additional_args)
	additional_args = additional_args or {}
	vim.keymap.set("n", keys, func, additional_args)
end
