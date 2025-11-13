return {
	{
		'theHamsta/nvim-dap-virtual-text',
		dependencies = { 'mfussenegger/nvim-dap' },
		opts = {
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			display_callback = function(variable, buf, stackframe, node, options)
				if options.virt_text_pos == 'inline' then
					return ' = ' .. variable.value
				else
					return variable.name .. ' = ' .. variable.value
				end
			end,
		},
	},

	{
		'nvim-telescope/telescope-dap.nvim',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-telescope/telescope.nvim',
		},
		config = function()
			require('telescope').load_extension('dap')
		end,
		keys = {
			{ '<leader>ds', function() require('telescope').extensions.dap.commands() end, desc = 'Debug: Commands' },
			{ '<leader>dC', function() require('telescope').extensions.dap.configurations() end, desc = 'Debug: Configurations' },
			{ '<leader>dL', function() require('telescope').extensions.dap.list_breakpoints() end, desc = 'Debug: List Breakpoints' },
			{ '<leader>dv', function() require('telescope').extensions.dap.variables() end, desc = 'Debug: Variables' },
			{ '<leader>df', function() require('telescope').extensions.dap.frames() end, desc = 'Debug: Frames' },
		},
	},
}
