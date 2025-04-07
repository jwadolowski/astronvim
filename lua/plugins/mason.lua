-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = {
        "stylua",
        "yamllint",
        "vale",
        -- add more arguments for adding more null-ls sources
      }

      -- Remove tfsec if it was added elsewhere
      opts.ensure_installed = vim.tbl_filter(function(tool) return tool ~= "tfsec" end, opts.ensure_installed)
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        -- add more arguments for adding more debuggers
      },
    },
  },
  -- Add an override for mason-tool-installer to remove tfsec
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      -- Remove tfsec from ensure_installed if it exists
      opts.ensure_installed = vim.tbl_filter(function(tool) return tool ~= "tfsec" end, opts.ensure_installed or {})
    end,
  },
}
