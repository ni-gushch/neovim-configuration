return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {

      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "cpptools" },
        automatic_installation = true,
      })
    end,
  },

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
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }
      dap.adapters.lldb = {
        type = "executable",
        command = "~/.local/share/nvim/mason/packages/codelldb/extension/lldb/bin/lldb", -- adjust as needed
        name = "lldb",
      }

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
      vim.keymap.set("n", "<F5>", function()
        require("dap").continue()
      end, { desc = "Start (continue) debgging" })
      vim.keymap.set("n", "<F10>", function()
        require("dap").step_over()
      end, { desc = "Step over" })
      vim.keymap.set("n", "<F11>", function()
        require("dap").step_into()
      end, { desc = "Step into" })
      vim.keymap.set("n", "<F12>", function()
        require("dap").step_out()
      end, { desc = "Step out" })
      vim.keymap.set("n", "<Leader>dtb", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Debuggind toggle breakpoint" })
      vim.keymap.set("n", "<Leader>dsb", function()
        require("dap").set_breakpoint()
      end, { desc = "Debugging set breakpoint" })
      vim.keymap.set("n", "<Leader>dlp", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Debugging set breadpoint log point message" })
      vim.keymap.set("n", "<Leader>ddr", function()
        require("dap").repl.open()
      end, { desc = "Debugging repl open" })
      vim.keymap.set("n", "<Leader>ddl", function()
        require("dap").run_last()
      end, { desc = "Debugging run last" })
      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "Debugging dap ui widgets hover" })
      vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
      end, { desc = "Debugging dap ui widgets preview" })
      vim.keymap.set("n", "<Leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end, { desc = "Debugging dap ui centered float widgets" })
      vim.keymap.set("n", "<Leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, { desc = "Debugging dap ui centerd float widgets scopes" })
    end,
  },
}
