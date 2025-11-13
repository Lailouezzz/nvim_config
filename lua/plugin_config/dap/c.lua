local dap = require('dap')

dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = function()
			local args_string = vim.fn.input('Arguments: ')
			return vim.split(args_string, " +")
		end,
		runInTerminal = false,
	},
	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		pid = require('dap.utils').pick_process,
		args = {},
	},
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
