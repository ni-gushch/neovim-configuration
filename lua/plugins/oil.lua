return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require("oil")
    oil.setup()
    normal_map("-", oil.toggle_float, {})
  end,
}
