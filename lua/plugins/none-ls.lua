-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,

      -- shfmt options:
      -- -i,  --indent uint       0 for tabs (default), >0 for number of spaces
      -- -ci, --case-indent       switch cases will be indented
      --
      -- Refs:
      -- - https://google.github.io/styleguide/shellguide.html
      null_ls.builtins.formatting.shfmt.with {
        extra_args = { "-i", "2", "-ci" },
        -- shfmt works just fine for Bash-like .zsh files too
        filetypes = { "sh", "zsh" },
      },

      -- required to format markdown files
      null_ls.builtins.formatting.prettierd,
    }
    return config -- return final config table
  end,
}
