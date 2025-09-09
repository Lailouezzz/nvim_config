
require("telescope").setup({
	defaults = {
		layout_strategy = "flex",
		layout_config = {
			width = 0.95,
		},
		path_display = { "smart" },
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
				["s"] = require("telescope.actions").select_horizontal,
			},
			i = {
				["<C-s>"] = require("telescope.actions").select_horizontal,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("fzf")
