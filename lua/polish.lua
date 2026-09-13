-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Pasting into a :terminal could insert the text twice (opencode + Ghostty).
--
-- Ghostty writes a paste in three chunks -- ESC[200~, body, ESC[201~ -- which is
-- legal but makes Neovim stream it as phases 1..3 instead of one -1. Neovim
-- wraps every phase in its own ESC[200~..ESC[201~, and the phase carrying the
-- end marker has no body, so the child gets a stray *empty* paste after the real
-- one. opencode reads that as an image-only clipboard and pastes it again.
-- iTerm2 writes the paste in one chunk, so it never triggers this.
--
-- So join the chunks and forward them as a single non-streamed paste: one
-- wrapper, no empty tail. The wrapper has to stay, otherwise the child cannot
-- tell a paste from typing and newlines arrive as Enter.
-- https://github.com/anomalyco/opencode/issues/34078
do
  local parts = nil
  local default_paste = vim.paste
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.paste = function(lines, phase)
    -- phase: -1 = whole paste in one call, 1 = first chunk, 2 = middle, 3 = last
    if vim.bo.buftype ~= "terminal" then return default_paste(lines, phase) end

    if phase == 1 or phase == -1 then parts = {} end
    if not parts then return default_paste(lines, phase) end
    parts[#parts + 1] = table.concat(lines, "\n")
    if phase ~= 3 and phase ~= -1 then return true end

    local text = table.concat(parts)
    parts = nil
    -- An empty paste carries nothing; never forward one.
    if text == "" then return true end
    return default_paste(vim.split(text, "\n"), -1)
  end
end
