return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<M-Down>",
				["Add Cursor Up"]   = "<M-Up>",
			}
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
		config = true,
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
