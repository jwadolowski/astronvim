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
      -- NGINX tree-sitter parser seems to be broken, keep it off (which also
      -- stops `auto_install` from fetching it). Wraps AstroNvim's own default,
      -- which disables treesitter in large buffers.
      enabled = function(lang, bufnr) return lang ~= "nginx" and not require("astrocore.buffer").is_large(bufnr) end,
    },
  },
}
