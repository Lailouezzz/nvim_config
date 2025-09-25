require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd" },
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

vim.lsp.config("clangd", {
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
})
vim.lsp.enable("clangd")
