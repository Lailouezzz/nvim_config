vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vue", "html" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = false
	end
})
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.go',
	callback = function()
		local params = vim.lsp.util.make_range_params(0, "utf-8") --[[@as table<string, any>]]
		params.context = { only = { "source.organizeImports" }, diagnostics = {} }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
				elseif r.command then
					vim.lsp.buf_request(0, "workspace/executeCommand", r.command)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})
vim.filetype.add({
	extension = {
		h = "c",
	},
})
