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

			local ts_ok, ts = pcall(require, "nvim-treesitter")
			if ts_ok and type(ts.install) == "function" then
				ts.install(parsers)
			else
				pcall(function()
					require("nvim-treesitter.configs").setup({
						ensure_installed = parsers,
						sync_install = false,
						highlight = { enable = true },
						indent = { enable = true },
					})
				end)
			end

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
