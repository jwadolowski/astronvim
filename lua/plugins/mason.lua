-- Customize Mason

---@type LazySpec
return {
  -- Ensure groovy-language-server is installed via mason-lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "groovyls" })
    end,
  },
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      -- Remove tfsec from ensure_installed if they exist
      opts.ensure_installed = vim.tbl_filter(function(tool) return tool ~= "tfsec" end, opts.ensure_installed or {})
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "groovy-language-server" })
    end,
  },
}
