local function no_configurations(config)
	config.configurations = {}
	require('mason-nvim-dap').default_setup(config)
end

local function get_venv_path()
	local venv = vim.fn.finddir('venv', vim.fn.getcwd() .. ';')
	if venv ~= '' then
		return vim.fn.fnamemodify(venv, ':p')
	end
	return nil
end

return {
	{
		'mason-org/mason.nvim',
		config = function()
			require('mason').setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					border = "rounded",
				},
			})
		end,
	},

	{
		'jay-babu/mason-nvim-dap.nvim',
		dependencies = {
			'mason-org/mason.nvim',
			'mfussenegger/nvim-dap',
		},
		config = function()
			require('mason-nvim-dap').setup({
				automatic_installation = true,
				ensure_installed = {
					'python',
					'codelldb',
					'cppdbg',
					'coreclr',
					'delve',
					'python-lsp-server',
				},
				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end,
					python = function(config)
						config.adapters = {
							type = "executable",
							command = "/usr/bin/python3",
							args = { "-m", "debugpy.adapter" },
						}
						require('mason-nvim-dap').default_setup(config)
					end,
					codelldb = no_configurations,
					cppdbg = no_configurations,
					delve = no_configurations,
					coreclr = function(config)
						config.adapters = {
							type = 'executable',
							command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
							args = { '--interpreter=vscode' },
						}
						require('mason-nvim-dap').default_setup(config)
					end,
				},
			})
		end,
	},

	{
		'mason-org/mason-lspconfig.nvim',
		dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "gopls", "lua_ls" },
				automatic_enable = false,
				automatic_installation = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			'mason-org/mason-lspconfig.nvim',
			"saghen/blink.cmp",
		},
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(args)
					local buf = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
					end
					local tel = require("telescope.builtin")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gd", tel.lsp_definitions, "Go to definition")
					map("n", "gi", tel.lsp_implementations, "Go to implementation")
					map("n", "gr", tel.lsp_references, "Go to references")
					map("n", "K", vim.lsp.buf.hover, "Hover docs")
					map("n", "<leader>E", vim.diagnostic.open_float, "Diagnostics float")
					map("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")
					if client and client.name == "zls" and client:supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = buf,
							callback = function() vim.lsp.buf.format({ async = false }) end,
						})
					end
					if client and client.name == "roslyn" then
						vim.lsp.inlay_hint.enable(true, { bufnr = buf })
					end
					if client and client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh({ bufnr = buf })
						vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
							buffer = buf,
							callback = function() vim.lsp.codelens.refresh({ bufnr = buf }) end,
						})
					end
				end,
			})
		end,
		config = function()
			local caps = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("clangd", {
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp", "tpp", "inl", "ipp" },
				capabilities = caps,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=never",
				},
			})
			vim.lsp.enable("clangd")

			vim.lsp.config("zls", {
				capabilities = caps,
				cmd_env = {
					ZIG_LOCAL_CACHE_DIR = "/tmp/zig-cache",
					ZIG_GLOBAL_CACHE_DIR = "/tmp/zig-cache-global",
				},
				settings = {
					zls = {
						enable_build_on_save = true,
						build_on_save_step = "check",
					},
				},
			})
			vim.lsp.enable("zls")

			local dotnet_path = vim.env.PATH
			if vim.uv.os_uname().sysname == "Darwin" then
				dotnet_path = vim.env.HOME .. '/.dotnet:' .. dotnet_path
			end
			vim.lsp.config("roslyn", {
				capabilities = caps,
				cmd_env = { PATH = dotnet_path },
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
			-- NB: vim.lsp.enable("roslyn") intentionnellement absent —
			-- roslyn.nvim gère son propre démarrage via vim.lsp.start()

			vim.lsp.config("gopls", {
				capabilities = caps,
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
						usePlaceholders = true,
					},
				},
			})
			vim.lsp.enable("gopls")

			vim.lsp.config("ts_ls", {
				capabilities = caps,
				filetypes = { "typescript", "html", "typescriptreact", "javascript", "javascriptreact" },
				root_markers = { "package.json", "tsconfig.json" },
			})
			vim.lsp.enable("ts_ls")

			vim.lsp.config("pylsp", {
				before_init = function(_, config)
					local venv = get_venv_path()
					if venv then
						config.settings.pylsp.plugins.jedi.environment = venv
					end
				end,
				capabilities = caps,
				filetypes = { "python" },
				settings = {
					pylsp = {
						plugins = {
							jedi = {},
							pycodestyle = { enabled = false },
						},
					},
				},
			})
			vim.lsp.enable("pylsp")

			vim.lsp.config("lua_ls", {
				capabilities = caps,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						diagnostics = { globals = { "vim" } },
						telemetry = { enable = false },
					},
				},
			})
			vim.lsp.enable("lua_ls")
		end,
	},
}
