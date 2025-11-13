local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

plugins = {
	{
		"danymat/neogen", 
		dependencies = "nvim-treesitter/nvim-treesitter", 
		config = true,
		version = "*" 
	},
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup()
		end,
		cmd = "Neogen",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- use latest stable
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>cp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.cmd([[do FileType]])
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
				desc = "Toggle Diffview window",
			},
		},
		config = function()
			require("diffview").setup()
		end,
	},
	{'akinsho/git-conflict.nvim', version = "*", config = true},
	{ "lewis6991/gitsigns.nvim" },
	{
		"jiaoshijie/undotree",
		dependencies = { "nvim-lua/plenary.nvim" },
		---@module 'undotree.collector'
		---@type UndoTreeCollector.Opts
		opts = {},
		keys = { -- load the plugin only when using it's keybinding:
			{ "UU", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	},
	"nvim-tree/nvim-web-devicons",
	{ "nvim-telescope/telescope.nvim", dependencies = { "tsakirist/telescope-lazy.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } } },
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "markdown"},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true, -- Default mapping <F1> in normal mode.
			auto_update = true, -- Update header when saving.
			user = "ale-boud", -- Your user.
			mail = "ale-boud@student.42lehavre.fr", -- Your mail.
			-- add other options.
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},
	{ import = "plugins.bufresize" },
	{ import = "plugins.mason" },
	{ import = "plugins.dap" },
	{ import = "plugins.dap-ui" },
	{ import = "plugins.dap-extras" },
	{ import = "plugins.lsp-lens" }
}

opts = {}

require("lazy").setup(plugins, opts)

