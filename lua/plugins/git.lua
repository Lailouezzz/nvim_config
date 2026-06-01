return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require('gitsigns').setup({
				on_attach = function(bufnr)
					local gs = require('gitsigns')
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end
					map('n', ']c', function()
						if vim.wo.diff then vim.cmd.normal({ ']c', bang = true })
						else gs.nav_hunk('next') end
					end)
					map('n', '[c', function()
						if vim.wo.diff then vim.cmd.normal({ '[c', bang = true })
						else gs.nav_hunk('prev') end
					end)
					map('n', '<leader>hs', gs.stage_hunk)
					map('n', '<leader>hr', gs.reset_hunk)
					map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
					map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
					map('n', '<leader>hS', gs.stage_buffer)
					map('n', '<leader>hR', gs.reset_buffer)
					map('n', '<leader>hp', gs.preview_hunk)
					map('n', '<leader>hi', gs.preview_hunk_inline)
					map('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
					map('n', '<leader>hd', gs.diffthis)
					map('n', '<leader>hD', function() gs.diffthis('~') end)
					map('n', '<leader>hQ', function() gs.setqflist('all') end)
					map('n', '<leader>hq', gs.setqflist)
					map('n', '<leader>tb', gs.toggle_current_line_blame)
					map('n', '<leader>tw', gs.toggle_word_diff)
					map({ 'o', 'x' }, 'ih', gs.select_hunk)
				end,
			})
		end,
	},

	{
		"sindrets/diffview.nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
		keys = {
			{
				"dv",
				function()
					if next(require("diffview.lib").views) == nil then
						vim.cmd("DiffviewOpen")
					else
						vim.cmd("DiffviewClose")
					end
				end,
				desc = "Toggle Diffview",
			},
		},
		config = function()
			require("diffview").setup()
		end,
	},

	{
		'akinsho/git-conflict.nvim',
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
}
