return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup({
        completion = {
          crates = {
            enabled = true, -- disabled by default
            max_results = 8, -- The maximum number of search results to display
            min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
          },
        },
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- the same on_attach function as for your other lsp's
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      })

      local crates = require("crates")

      normal_map("<leader>ct", crates.toggle, { silent = true, desc = "[CRATES] toggle" })
      normal_map("<leader>cr", crates.reload, { silent = true, desc = "[CRATES] reload" })

      normal_map(
        "<leader>cv",
        crates.show_versions_popup,
        { silent = true, desc = "[CRATES] Show version popup" }
      )
      normal_map(
        "<leader>cf",
        crates.show_features_popup,
        { silent = true, desc = "[CRATES] Show features popup" }
      )
      normal_map(
        "<leader>cd",
        crates.show_dependencies_popup,
        { silent = true, desc = "[CRATES] Show dependencies popup" }
      )

      normal_map("<leader>cu", crates.update_crate, { silent = true, desc = "[CRATES] Update crate" })
      vim.keymap.set("v", "<leader>cu", crates.update_crates, { silent = true, desc = "[CRATES] Update crates" })
      normal_map("<leader>ca", crates.update_all_crates, { silent = true, desc = "[CRATES] Update all crates" })
      normal_map("<leader>cU", crates.upgrade_crate, { silent = true, desc = "[CRATES] Upgrade crate" })
      vim.keymap.set(
        "v",
        "<leader>cU",
        crates.upgrade_crates,
        { silent = true, desc = "[CRATES] Upgrade crates" }
      )
      normal_map("<leader>cA", crates.upgrade_all_crates, { silent = true, desc = "[CRATES] Upgrade all crates" })

      normal_map(
        "<leader>cx",
        crates.expand_plain_crate_to_inline_table,
        { silent = true, desc = "[CRATES] Expand plain crate to inline table" }
      )
      normal_map(
        "<leader>cX",
        crates.extract_crate_into_table,
        { silent = true, desc = "[CRATES] Extract crate into table" }
      )

      normal_map("<leader>cH", crates.open_homepage, { silent = true, desc = "[CRATES] Open homepage" })
      normal_map("<leader>cR", crates.open_repository, { silent = true, desc = "[CRATES] Open repository" })
      normal_map("<leader>cD", crates.open_documentation, { silent = true, desc = "[CRATES] Open documentation" })
      normal_map("<leader>cC", crates.open_crates_io, { silent = true, desc = "[CRATES] Open crates io" })
      normal_map("<leader>cL", crates.open_lib_rs, { silent = true, desc = "[CRATES] Open lib rs" })
    end,
  },
}
