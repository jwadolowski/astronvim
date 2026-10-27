---@type LazySpec
return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      tools = {
        opencode = {
          keys = {
            -- opencode misreads nvim's ESC; send kitty-encoded ESC (CSI 27u)
            esc = { "<esc>", function(t) vim.api.nvim_chan_send(t.job, "\27[27u") end }, -- mode defaults to "t"; no string keys (tool is stored in vim.b)
          },
        },
      },
      win = {
        split = { width = 0.4 }, -- fraction of vim.o.columns (<=1); default 80 cols
        keys = {
          files = false, -- disable <C-f> file picker in CLI terminal
        },
      },
    },
  },
}
