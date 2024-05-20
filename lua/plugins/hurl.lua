return {
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "split",
      -- Default formatter
      formatters = {
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          "--parser",
          "html",
        },
      },
    },
    keys = {
      -- Run API request
      -- { "<leader>xA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      -- { "<leader>xa", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
      -- { "<leader>xte", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      -- { "<leader>xtm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
      -- { "<leader>xtv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      -- { "<leader>xh", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    },
  },
}
