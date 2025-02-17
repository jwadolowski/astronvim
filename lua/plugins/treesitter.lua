-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "hurl",
      "gotmpl",
      -- add more arguments for adding more treesitter parsers
    },
    -- NGINX tree-sitter parser seems to be broken, do not install it
    ignore_install = { "nginx" },
  },
}
