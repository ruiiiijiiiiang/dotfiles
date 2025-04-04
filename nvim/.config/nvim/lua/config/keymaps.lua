-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
local smart_splits = require("smart-splits")
local dropbar_api = require("dropbar.api")

map("n", "<Enter>", "a<Enter><Esc>", { desc = "Enter in normal mode" })

-- insert mode movement
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")

-- move between split panes
map("n", "<C-h>", smart_splits.move_cursor_left)
map("n", "<C-j>", smart_splits.move_cursor_down)
map("n", "<C-k>", smart_splits.move_cursor_up)
map("n", "<C-l>", smart_splits.move_cursor_right)
-- resize panes
map("n", "<C-A-h>", smart_splits.resize_left)
map("n", "<C-A-j>", smart_splits.resize_down)
map("n", "<C-A-k>", smart_splits.resize_up)
map("n", "<C-A-l>", smart_splits.resize_right)

-- CodeSnap
map("x", "<leader>Cc", "<Esc><Cmd>CodeSnap<Cr>", { desc = "Save selected code snapshot into clipboard" })
map("x", "<leader>Cs", "<Esc><Cmd>CodeSnapSave<Cr>", { desc = "Save selected code snapshot in ~/Pictures" })

-- BufferLine
map("n", "<leader>bs", ":BufferLinePick<CR>", { desc = "Select buffer" })

-- Center search
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

-- Dropbar
map("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
map("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
map("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
