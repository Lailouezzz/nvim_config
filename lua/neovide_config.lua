if vim.g.neovide then
	font_size = 10
	local function change_font_size(offset)
		font_size = font_size + offset
		vim.o.guifont = "Fira Code:h" .. font_size,
		{noremap = true}
	end
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_cursor_animation_length = 0.05
	change_font_size(0)
	vim.keymap.set("n", "<leader>f+", function () change_font_size(1) end)
	vim.keymap.set("n", "<leader>f-", function () change_font_size(-1) end)
end
