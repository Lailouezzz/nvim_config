return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<M-Down>",
				["Add Cursor Up"]   = "<M-Up>",
			}

			-- En sortant, VM execute les `iunmap <buffer>` de b:VM_unmaps sur les
			-- touches qu'il s'est appropriees (<CR>, <Up>, <Down>...) : il les
			-- supprime au lieu de les restaurer, ce qui detruit les mappings
			-- buffer-local de blink.cmp. Blink ne les repose jamais, car son
			-- apply.keymap_to_current_buffer sort immediatement des qu'il trouve
			-- un mapping "blink.cmp:" survivant (<Tab>, que VM n'unmappe qu'en
			-- mode normal). On efface donc les rescapes pour que le prochain
			-- InsertEnter reapplique le jeu complet.
			vim.api.nvim_create_autocmd("User", {
				pattern = "visual_multi_exit",
				callback = function()
					local buf = vim.api.nvim_get_current_buf()
					for _, mode in ipairs({ "i", "s" }) do
						for _, map in ipairs(vim.api.nvim_buf_get_keymap(buf, mode)) do
							if map.desc and vim.startswith(map.desc, "blink.cmp: ") then
								pcall(vim.api.nvim_buf_del_keymap, buf, mode, map.lhs)
							end
						end
					end
				end,
			})
		end,
	},

	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		version = "*",
		cmd = "Neogen",
		keys = { { "<leader>dg", "<cmd>Neogen<CR>", desc = "Generate doc comment" } },
		config = function()
			require("neogen").setup()
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"jiaoshijie/undotree",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = { { "UU", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" } },
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{ "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview" },
		},
		config = function()
			vim.cmd([[do FileType]])
		end,
	},
}
