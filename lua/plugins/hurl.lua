return {
  {
    "Orange-OpenSource/hurl",
    config = function() vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/hurl/contrib/vim") end,
  },
}
