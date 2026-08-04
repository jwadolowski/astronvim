---@type LazySpec
return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      win = {
        split = { width = 0.4 }, -- fraction of vim.o.columns (<=1); default 80 cols
      },
    },
  },
}
