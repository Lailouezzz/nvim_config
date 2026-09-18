return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"zig", "c", "lua", "vim", "vimdoc", "query",
				"elixir", "heex", "javascript", "typescript", "html", "markdown",
				"go", "gomod", "gowork", "gosum", "python", "c_sharp",
			}

			local ts = require("nvim-treesitter")

			-- La branche main n'a plus de `ensure_installed` : setup() ne prend
			-- que `install_dir`. L'installation passe par install(), qui compile
			-- via le CLI tree-sitter -- sans lui, rien ne s'installe.
			if vim.fn.executable("tree-sitter") == 0 then
				vim.notify(
					"tree-sitter CLI introuvable : les parsers ne seront pas installes",
					vim.log.levels.WARN
				)
			else
				local installed = ts.get_installed("parsers")
				local missing = vim.tbl_filter(function(parser)
					return not vim.tbl_contains(installed, parser)
				end, parsers)
				if #missing > 0 then
					ts.install(missing, { summary = true })
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Roslyn gère le highlighting C# lui-même
					if args.match == "cs" then return end
					pcall(vim.treesitter.start, args.buf)
					-- Indentation is left to each filetype's native engine (cindent,
					-- built-in indent/*.lua scripts, ...): nvim-treesitter's own
					-- indentexpr mishandles common cases like a blank line freshly
					-- opened between a matching pair of brackets.
					-- https://github.com/nvim-treesitter/nvim-treesitter/issues/4079
				end,
			})
		end,
	},
}
