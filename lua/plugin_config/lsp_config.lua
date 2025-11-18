local M = {}
local lspconfig = require("lspconfig")
function M.on_attach(_, _)
	local opts = { noremap = true, silent = true }
	local telescope = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
	vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
	vim.keymap.set("n", "gr", telescope.lsp_references,  opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, {})
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp", "tpp", "inl", "ipp" },
	capabilities = M.capabilities,
	on_attach = M.on_attach,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=never",
	},
})
vim.lsp.enable("clangd")

local dotnet_path_env = vim.env.PATH
if vim.fn.has("mac") then
	dotnet_path_env = vim.env.HOME .. '/.dotnet:' .. dotnet_path_env
end
vim.lsp.config("roslyn", {
	cmd_env = {
		PATH = dotnet_path_env
	},
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_parameters = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
		},
	},
})
vim.lsp.enable("roslyn")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "roslyn" then
			vim.lsp.inlay_hint.enable(true, {bufnr = args.buf})
		end
	end,
})

vim.lsp.config("gopls", {
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})
vim.lsp.enable("gopls")

return M
