return {
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio'
		},
		config = function()
			local dap, dapui = require('dap'), require('dapui')
			
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			})

			-- Auto-ouverture/fermeture de l'UI
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		keys = {
			{ '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
			{ '<leader>de', function() require('dapui').eval() end, mode = {'n', 'v'}, desc = 'Debug: Evaluate' },
			{ '<leader>dh', function() require('dapui').float_element('scopes', { enter = true }) end, desc = 'Debug: Hover Variables' },
			{ '<leader>dw', function() require('dapui').float_element('watches', { enter = true }) end, desc = 'Debug: Open Watches' },
		},
	},
}
