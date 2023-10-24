vim.g.mapleader = " " 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "G", "Gzz") 
vim.keymap.set("i", "<ESC>", "<ESC>zz:w<CR>")
-- Keybindings-- Keybindings with Leader Key
local quarto = require("quarto")
vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, {silent = true, noremap = true})
