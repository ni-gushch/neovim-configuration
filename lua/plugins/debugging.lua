return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      require("dapui").setup()
      require("dap-go").setup()

      -- cpp c and rust debugger configuration
      local debug_adapter_path = "/home/ngushcharin/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = debug_adapter_path,
      }
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- adjust as needed
        name = "lldb",
      }

      -- dap.configurations.cpp = {
      --   {
      --     name = "Launch file",
      --     type = "cppdbg",
      --     request = "launch",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --     stopAtEntry = true,
      --     setupCommands = {
      --       {
      --         text = "-enable-pretty-printing",
      --         description = "enable pretty printing",
      --         ignoreFailures = false,
      --       },
      --     },
      --   },
      --   {
      --     name = "Attach to gdbserver :1234",
      --     type = "cppdbg",
      --     request = "launch",
      --     MIMode = "gdb",
      --     miDebuggerServerAddress = "localhost:1234",
      --     miDebuggerPath = "/usr/bin/gdb",
      --     cwd = "${workspaceFolder}",
      --     program = function()
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     setupCommands = {
      --       {
      --         text = "-enable-pretty-printing",
      --         description = "enable pretty printing",
      --         ignoreFailures = false,
      --       },
      --     },
      --   },
      -- }
      -- dap.configurations.c = dap.configurations.cpp
      -- dap.configurations.rust = dap.configurations.cpp

      -- dap ui opening configuration
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle dap ui interface" })
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Debug continue" })
    end,
  },
}
