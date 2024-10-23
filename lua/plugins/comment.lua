return {
  {
    "numToStr/Comment.nvim",
    opts = {
      -- Fix helm commentline
      --
      -- Ref: https://github.com/numToStr/Comment.nvim/issues/172
      pre_hook = function()
        if vim.bo.filetype == "helm" then return vim.bo.commentstring end
      end,
    },
  },
}
