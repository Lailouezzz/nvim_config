if vim.g.neovide then
	font_size = 10
	opacity = 0.95
	local function change_font_size(offset)
		font_size = font_size + offset
		vim.o.guifont = "Fira Code:h" .. font_size,
		{noremap = true}
	end
	local function change_opacity(offset)
		opacity = opacity + offset
		vim.g.neovide_opacity = opacity
	end
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_cursor_animation_length = 0.05
	change_font_size(0)
	change_opacity(0)
	vim.keymap.set("n", "<leader>f+", function () change_font_size(2) end)
	vim.keymap.set("n", "<leader>f-", function () change_font_size(-2) end)
	vim.keymap.set("n", "<leader>o+", function () change_opacity(0.05) end)
	vim.keymap.set("n", "<leader>o-", function () change_opacity(-0.05) end)
end
