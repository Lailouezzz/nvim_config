local config = require("utils").config
if vim.g.neovide then
	if vim.fn.has("mac") then
		vim.g.neovide_input_macos_option_key_is_meta = 'both'
	end
	local function change_font_size(offset)
		config.font_size = config.font_size + offset
		vim.o.guifont = "Fira Code:h" .. config.font_size,
		{noremap = true}
	end
	local function change_opacity(offset)
		config.opacity = config.opacity + offset
		vim.g.neovide_opacity = config.opacity
	end
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_cursor_animation_length = 0.05
	change_font_size(0)
	change_opacity(0)
	vim.keymap.set("n", "<leader>f=", function () change_font_size(2) end)
	vim.keymap.set("n", "<leader>f-", function () change_font_size(-2) end)
	vim.keymap.set("n", "<leader>o=", function () change_opacity(0.05) end)
	vim.keymap.set("n", "<leader>o-", function () change_opacity(-0.05) end)
end
