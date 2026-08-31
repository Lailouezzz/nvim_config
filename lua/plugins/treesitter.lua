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

			require("nvim-treesitter").setup({ ensure_installed = parsers })

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
