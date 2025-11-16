return {
	{
		'mason-org/mason.nvim',
		config = function()
			require('mason').setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					},
					border = "rounded",
				}
			})
		end
	},

	{
		'mason-org/mason-lspconfig.nvim',
		dependencies = {
			'mason-org/mason.nvim',
			'neovim/nvim-lspconfig'
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "omnisharp" },
				automatic_enable = false,
			})
		end
	},

	-- Mason-DAP : pont entre Mason et nvim-dap
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
					'python',			-- debugpy
					'codelldb',			-- C, C++, Rust
					'cppdbg',			-- Microsoft C, C++
					'coreclr',			-- .NET (C#, F#)
					'delve',			-- Go
				},

				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end,
					
					python = function(config)
						config.adapters = {
							type = "executable",
							command = "/usr/bin/python3",
							args = {
								"-m",
								"debugpy.adapter",
							},
						}
						require('mason-nvim-dap').default_setup(config)
					end,

					coreclr = function(config)
						config.adapters = {
							type = 'executable',
							command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
							args = {'--interpreter=vscode'}
						}
						require('mason-nvim-dap').default_setup(config)
					end,
				},
			})
		end
	},
}
