-- The official Hurl tree-sitter grammar is broken, so it was replaced with
-- the official vim syntax file, and TS is disabled in plugins/treesitter.lua.
-- Sparse checkout keeps the clone down to just contrib/vim instead of the
-- whole hurl repo.
--
-- Refs:
-- - https://github.com/pfeiferj/tree-sitter-hurl
-- - https://github.com/Orange-OpenSource/hurl/blob/master/contrib/vim/syntax/hurl.vim

---@type LazySpec
return {
  "Orange-OpenSource/hurl",
  name = "hurl-vim-syntax",
  init = function(plugin) vim.opt.rtp:append(plugin.dir .. "/contrib/vim") end,
  build = function(plugin) vim.system({ "git", "-C", plugin.dir, "sparse-checkout", "set", "contrib/vim" }):wait() end,
}
