-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "gotmpl",
      -- add more arguments for adding more treesitter parsers
    },
    -- NGINX tree-sitter parser seems to be broken, do not install it
    -- Hurl tree-sitter parser doesn't seem to work correctly and yields a lot of errors
    ignore_install = { "nginx", "hurl" },
  },
}
