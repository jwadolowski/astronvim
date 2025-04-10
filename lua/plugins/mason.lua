-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      -- Remove tfsec and buf-language-server from ensure_installed if they exist
      opts.ensure_installed = vim.tbl_filter(
        function(tool) return tool ~= "tfsec" and tool ~= "buf-language-server" end,
        opts.ensure_installed or {}
      )
    end,
  },
}
