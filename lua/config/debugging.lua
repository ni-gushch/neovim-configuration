local dap = require("dap")
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

-- CODELLDB (Rust/C/C++)
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = { command = mason_bin .. "codelldb", args = { "--port", "${port}" } },
}

-- Go (Delve)
dap.adapters.go = function(callback, _)
  local handle
  local port = 38697
  handle, _ = vim.loop.spawn(mason_bin .. "dlv", { args = { "dap", "-l", "127.0.0.1:" .. port } }, function(code)
    if handle and not handle:is_closing() then handle:close() end
    print("Delve exited with code:", code)
  end)
  vim.defer_fn(function() callback({ type = "server", host = "127.0.0.1", port = port }) end, 100)
end

-- .NET (CoreCLR via netcoredbg)
dap.adapters.coreclr = {
  type = "executable",
  command = mason_bin .. "netcoredbg",
  args = { "--interpreter=vscode" },
}

-- Configs
dap.configurations.rust = {
  {
    name = "Debug executable (cargo build --bin ...)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug main",
    request = "launch",
    program = "${workspaceFolder}",
  },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/YourApp.dll", "file")
    end,
  },
}
