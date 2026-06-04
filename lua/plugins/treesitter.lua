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

			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Roslyn gère le highlighting C# lui-même
					if args.match == "cs" then return end
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						pcall(function()
							vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end)
					end
				end,
			})
		end,
	},
}
