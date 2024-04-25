vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.showmode = true
vim.o.undofile = true
vim.o.noexpandtab = true
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.autoindent = true
vim.o.shiftround = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

vim.keymap.set("n", "<leader>e", ":Neotree<CR>")
vim.keymap.set("n", "<D-v>", '"+p')
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>tr", ":split term://zsh<CR>") 
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
