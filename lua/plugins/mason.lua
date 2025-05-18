-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  --
  -- Remove buf_ls once https://github.com/AstroNvim/astrocommunity/pull/1508 is merged
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      -- Remove tfsec and buf_ls from ensure_installed if they exist
      opts.ensure_installed = vim.tbl_filter(
        function(tool) return tool ~= "tfsec" and tool ~= "buf_ls" end,
        opts.ensure_installed or {}
      )
    end,
  },
}
