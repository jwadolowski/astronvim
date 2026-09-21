-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      ensure_installed = {
        "lua",
        "vim",
        "gotmpl",
        "groovy",
        -- add more arguments for adding more treesitter parsers
      },
      -- NGINX and Hurl TS parsers are broken
      enabled = function(lang, bufnr)
        return not vim.list_contains({ "nginx", "hurl" }, lang) and not require("astrocore.buffer").is_large(bufnr)
      end,
    },
  },
}
