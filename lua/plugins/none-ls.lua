-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,

      -- required to format markdown files
      null_ls.builtins.formatting.prettierd,

      -- relaxed yamllint settings
      null_ls.builtins.diagnostics.yamllint.with {
        extra_args = {
          "-d",
          "{ extends: relaxed, rules: { line-length: disable, empty-lines: disable, indentation: { indent-sequences: whatever } } }",
        },
      },
    })
  end,
}
