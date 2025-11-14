local cmp = require("cmp")

local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function (args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<ESC>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.abort()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	})
})

function leave_snippet()
	if
		((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
		and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
		and not require('luasnip').session.jump_active
	then
		require('luasnip').unlink_current()
	end
end

vim.api.nvim_command([[
	autocmd ModeChanged * lua leave_snippet()
]])
