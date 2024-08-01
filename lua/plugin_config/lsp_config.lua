require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "volar", "tsserver" }
})


local on_attach = function (_, _)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, {})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp", "tpp", "inl", "ipp" },
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
		"--header-insertion=never",
	},

})

require("lspconfig").tsserver.setup({
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
	init_options = {
		plugins = {
			{
				name = '@vue/typescript-plugin',
				location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
				languages = { 'vue' },
			},
		},
	},
	handlers = {
		-- Usually gets called after another code action
		-- https://github.com/jose-elias-alvarez/typescript.nvim/issues/17
		['_typescript.rename'] = function(_, result)
			return result
		end,
		-- 'Go to definition' workaround
		-- https://github.com/holoiii/nvim/commit/73a4db74fe463f5064346ba63870557fedd134ad
		['textDocument/definition'] = function(err, result, ...)
			result = vim.islist(result) and result[1] or result
			vim.lsp.handlers['textDocument/definition'](err, result, ...)
		end,
	},
})

require("lspconfig").volar.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
