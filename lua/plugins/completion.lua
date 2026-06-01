return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				keymap = {
					preset = "default",
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
					["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
					["<Esc>"] = { "hide", "fallback" },
					["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				},
				completion = {
					documentation = { auto_show = true, auto_show_delay_ms = 200 },
				},
			})
		end,
	},
}
