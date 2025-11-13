return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'jay-babu/mason-nvim-dap.nvim',
		},
		keys = {
			{ '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
			{ '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
			{ '<F11>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
			{ '<F12>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
			
			{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
			{ '<leader>dB', function()
				require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
			end, desc = 'Debug: Set Conditional Breakpoint' },
			{ '<leader>dc', function() require('dap').clear_breakpoints() end, desc = 'Debug: Clear Breakpoints' },
			
			{ '<leader>dr', function() require('dap').repl.open() end, desc = 'Debug: Open REPL' },
			{ '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
			{ '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
			{ '<leader>dR', function() require('dap').restart() end, desc = 'Debug: Restart' },
		},
		config = function()
			require("plugin_config.dap")
		end
	},
}
