return {
  {
    "GeorgesAlkhouri/nvim-aider",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = {
      "AiderTerminalToggle",
      "AiderHealth",
    },
    keys = {
      { "<C-a>", "<cmd>AiderTerminalToggle<cr>", desc = "Toggle Aider terminal", mode = { "n", "t" } },
      { "<leader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
      { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
      { "<leader>aa", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
      { "<leader>ad", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
      { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
    },
    config = true,
    opts = {
      args = {
        "--no-auto-commits",
        "--pretty",
        "--stream",
        "--cache-prompts",
        "--architect",
        "--code-theme",
        "dracula",
      },
      win = {
        position = "right",
      },
    },
  },
}
