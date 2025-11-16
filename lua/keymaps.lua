vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

local telescope = require("telescope.builtin")
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<leader>e", ":Neotree<CR>")
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
local saveKeymap = "<C-s>"
if vim.fn.has("mac") then
	saveKeymap = "<D-s>"
end
vim.keymap.set("n", saveKeymap, ":w<CR>", opts)
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>tt", require("utils").toggle_terminal, opts)
vim.keymap.set("n", "<leader>tr", require("utils").toggle_terminal_buf, opts)
vim.keymap.set("n", "<leader>mm", function() require("utils").exec_command("make") end, opts)
vim.keymap.set("n", "<leader>mf", function() require("utils").exec_command("make fclean") end, opts)
vim.keymap.set("n", "<leader>mr", function() require("utils").exec_command("make re") end, opts)
vim.keymap.set("n", "<leader>mp", function() require("utils").exec_command("make mrproper") end, opts)
vim.keymap.set("n", "<leader>mc", function() require("utils").exec_command("./configure.sh") end, opts)
local pasteTerminalKeymap = "<C-S-v"
if vim.fn.has("mac") then
	pasteTerminalKeymap = "<D-v>"
end
vim.keymap.set("t", pasteTerminalKeymap, "<C-\\><C-n>pi")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("i", "<C-BS>", "<C-w>", opts)
local pasteKeymap = "<C-v>"
if vim.fn.has("mac") then
	pasteKeymap = "<D-v>"
end
vim.keymap.set("i", pasteKeymap, function()
	local col = vim.fn.col('.')
	local line_len = vim.fn.col('$')
	
	if col == line_len then
		return '<C-o>p'
	else
		return '<C-o>P'
	end
end, { expr = true, silent = true })
vim.keymap.set("n", "<leader>dg", ":Neogen<CR>", opts)
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
vim.api.nvim_create_autocmd("WinClosed", {
	callback = function(args)
		local win = tonumber(args.match)
		if win and vim.api.nvim_win_get_config(win).relative ~= "" then
			return
		end
		require("bufresize").resize()
		require("utils").resize_fixed()
		require("bufresize").register()
	end,
})
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		require("bufresize").resize()
		require("utils").resize_fixed()
	end,
})
vim.api.nvim_create_autocmd("WinResized", {
	callback = function()
		require("utils").resize_fixed()
		require("bufresize").register()
	end,
})
local rightMoveKeymap = "<C-Right>"
if vim.fn.has("mac") then
	rightMoveKeymap = "<A-Right>"
end
vim.keymap.set({'n', 'i', 'v'}, rightMoveKeymap, function()
	local mode = vim.fn.mode()
	local start_line = vim.fn.line('.')
	local col = vim.fn.col('.')
	local line_len = vim.fn.col('$') - 1
	if col >= line_len and start_line == vim.fn.line('$') then
		vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), vim.fn.col('$')})
		return
	end
	if (col >= line_len and mode ~= 'i') or (col > line_len and mode == 'i') then
		vim.cmd('normal! j^')
		if mode == 'i'  then
			vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), 0})
		end
		return
	end

	if col ~= 1 and mode == 'i' then
		vim.cmd('normal! h')
	elseif mode == 'i' then
		vim.cmd('normal! k$')
	end

	vim.cmd('normal! e')

	if vim.fn.line('.') ~= start_line then
		vim.cmd('normal! k$')
	end
	if mode == 'i' then
		vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), vim.fn.col('.')})
	end
end)
local leftMoveKeymap = "<C-Left>"
if vim.fn.has("mac") then
	leftMoveKeymap = "<A-Left>"
end
vim.keymap.set({'n', 'i', 'v'}, leftMoveKeymap, function()
	local mode = vim.fn.mode()
	local start_line = vim.fn.line('.')
	local col = vim.fn.col('.')
	if col == 1 and start_line == 1 then
		return
	end
	if col == 1 then
		vim.cmd('normal! k$')
		if mode == 'i' then
			vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), vim.fn.col('.')})
		end
		return
	end
	vim.cmd('normal! b')

	if vim.fn.line('.') ~= start_line then
		vim.cmd('normal! j^')
		vim.api.nvim_win_set_cursor(0, {vim.fn.line('.'), 0})
	end
end)
