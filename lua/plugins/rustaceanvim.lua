return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      vim.g.rustaceanvim = function()
        local ok, mason_registry = pcall(require, "mason-registry")
        local adapter ---@type any
        if ok then
          -- rust tools configuration for debugging support
          local codelldb = mason_registry.get_package("codelldb")
          local extension_path = codelldb:get_install_path() .. "/extension/"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local liblldb_path = ""
          if vim.loop.os_uname().sysname:find("Windows") then
            liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
          elseif vim.fn.has("mac") == 1 then
            liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
          else
            liblldb_path = extension_path .. "lldb/lib/liblldb.so"
          end
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
        end

        return {
          -- Plugin configuration
          tools = {},
          -- LSP configuration
          server = {
            -- on_attach = vim.g.rustaceanvim.server.on_attach,
            on_attach = function(_, bufnr)
              -- you can also put keymaps in here
              -- stylua: ignore start
              print("we here in rust config")
              normal_map(
                "<leader>ca", function() vim.cmd.RustLsp("codeAction") end,
                { silent = true, buffer = bufnr }
              )
              normal_map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end)
              normal_map(
                "<leader>e", function() vim.cmd.RustLsp({ 'explainError', 'cycle' }) end,
                { desc = "Open [F]loating [D]iagnostic message" }
              )
              normal_map("<leader>df", function() vim.cmd.RustLsp("explainError") end)
              -- stylua: ignore stop
            end,
            default_settings = {
              -- rust-analyzer language server configuration
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  buildScripts = {
                    enable = true,
                  },
                },
              },
              -- Add clippy lints for Rust
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
          -- DAP configuration
          dap = {
            adapter = adapter,
          },
        }
      end
    end,
  },
}
