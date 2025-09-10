vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.showmode = true
vim.o.undofile = true
vim.o.expandtab = false
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.autoindent = true
vim.o.shiftround = true
vim.o.nu = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

local telescope = require("telescope.builtin")
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<leader>e", ":Neotree<CR>")
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>tr", ":botright split term://zsh<CR>:resize 15<CR>:set nonu<CR>") 
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("i", "<C-BS>", "<C-w>", opts)
vim.keymap.set("i", "<C-v>", "<C-o>P", opts)
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Trouver un fichier" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Recherche de texte en direct" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Basculer entre les buffers" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Rechercher dans l'aide" })
vim.keymap.set("n", "<leader>fo", telescope.oldfiles, { desc = "Fichiers récemment ouverts" })
vim.keymap.set("n", "<leader>fs", telescope.lsp_workspace_symbols, { desc = "Recherche dans les symbols courants" })
vim.keymap.set("n", "<leader>fS", telescope.lsp_dynamic_workspace_symbols, { desc = "Recherche dans tout les symbols courants" })
vim.keymap.set("n", "<leader>cm", telescope.commands, { desc = "Rechercher des commandes" })
vim.keymap.set("n", "<leader>km", telescope.keymaps, { desc = "Rechercher des raccourcis clavier" })
vim.keymap.set("n", "<leader>gb", telescope.git_branches, { desc = "Branches Git" })
vim.keymap.set("n", "<leader>gc", telescope.git_commits, { desc = "Commits Git" })
vim.keymap.set("n", "<leader>gs", telescope.git_status, { desc = "Statut Git" })
