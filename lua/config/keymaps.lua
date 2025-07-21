-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "Q", ":bd<CR>")
vim.keymap.set("n", ";", ":") --命令模式
vim.keymap.set("n", "<C-j>", "10j", { noremap = true })
vim.keymap.set("n", "<C-k>", "10k", { noremap = true })
