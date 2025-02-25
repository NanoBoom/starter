-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "<C-d>", "<C-o>diw", { desc = "Delete inner word" })
vim.keymap.set("i", "<C-u>", "<C-o>dI", { desc = "Delete to beginning of line" })
vim.keymap.set("i", "<C-k>", "<C-o>D", { desc = "Delete to end of line" })
vim.keymap.set("i", "<C-b>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("i", "<C-f>", "<Right>", { desc = "Move cursor right" })
vim.keymap.set("i", "<C-a>", "<Esc>^i", { desc = "Move to beginning of line and insert" })
vim.keymap.set("i", "<C-n>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set("i", "<C-p>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-j>", "<C-o>o", { desc = "Insert new line below" })
vim.keymap.set("i", "<C-l>", "<C-o>O", { desc = "Insert new line above" })

vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete without copy" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without copy" })
