return {
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true,
			auto_update = true,
			user = "ale-boud",
			mail = "ale-boud@student.42lehavre.fr",
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},

	{
		"kwkarlwang/bufresize.nvim",
		config = function()
			local opts = { noremap = true, silent = true }
			require("bufresize").setup({
				register = {
					keys = {
						{ "n", "<leader>w,", "10<C-w><", opts },
						{ "n", "<leader>w.", "10<C-w>>", opts },
						{ "n", "<leader>w+", "5<C-w>+",  opts },
						{ "n", "<leader>w-", "5<C-w>-",  opts },
						{ "n", "<leader>w_", "<C-w>_",   opts },
						{ "n", "<leader>w|", "<C-w>|",   opts },
						{ "n", "<leader>wo", "<C-w>|<C-w>_", opts },
					},
					trigger_events = { "BufWinEnter", "WinEnter" },
				},
				resize = {
					keys = {},
					trigger_events = {},
					increment = false,
				},
			})
		end,
	},

	{ "nvim-tree/nvim-web-devicons", lazy = true },
}
