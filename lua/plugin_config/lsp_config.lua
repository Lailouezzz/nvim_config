require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "vue_ls", "ts_ls" },
	automatic_enable = false,
})
local lspconfig = require("lspconfig")

local telescope = require("telescope.builtin")
local on_attach = function (_, _)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
	vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
	vim.keymap.set("n", "gr", telescope.lsp_references,  opts)
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
		"--header-insertion=never",
	},
	root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
})

require("lspconfig").ts_ls.setup({
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
	init_options = {
		plugins = {
			{
				name = '@vue/typescript-plugin',
				location = vim.fn.exepath("vue-language-server"),
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
