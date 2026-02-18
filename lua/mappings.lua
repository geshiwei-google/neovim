require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Terminal mode: jk to exit to normal mode
map("t", "jk", "<C-\\><C-n>", { desc = "Terminal exit to normal mode" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
