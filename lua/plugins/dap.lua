local function load_env(path)
	local env = vim.empty_dict()
	local file = io.open(path, "r")
	if not file then return env end
	for line in file:lines() do
		local key, value = line:match("^([^#][^=]*)=(.*)$")
		if key then
			env[key:match("^%s*(.-)%s*$")] = value:match("^%s*(.-)%s*$")
		end
	end
	file:close()
	return env
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "jay-babu/mason-nvim-dap.nvim" },
		keys = {
			{ "<F5>",        function() require("dap").continue() end,          desc = "Debug: Start/Continue" },
			{ "<F10>",       function() require("dap").step_over() end,         desc = "Debug: Step Over" },
			{ "<F11>",       function() require("dap").step_into() end,         desc = "Debug: Step Into" },
			{ "<F12>",       function() require("dap").step_out() end,          desc = "Debug: Step Out" },
			{ "<leader>db",  function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
			{ "<leader>dB",  function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, desc = "Debug: Set Conditional Breakpoint" },
			{ "<leader>dc",  function() require("dap").clear_breakpoints() end, desc = "Debug: Clear Breakpoints" },
			{ "<leader>dr",  function() require("dap").repl.open() end,         desc = "Debug: Open REPL" },
			{ "<leader>dl",  function() require("dap").run_last() end,          desc = "Debug: Run Last" },
			{ "<leader>dt",  function() require("dap").terminate() end,         desc = "Debug: Terminate" },
			{ "<leader>dR",  function() require("dap").restart() end,           desc = "Debug: Restart" },
		},
		config = function()
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint",          { text = "🔴", texthl = "DapBreakpoint",  linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DapBreakpoint",  linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected",  { text = "🚫", texthl = "DapBreakpoint",  linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped",             { text = "▶️", texthl = "DapStopped",     linehl = "debugPC", numhl = "" })
			vim.fn.sign_define("DapLogPoint",            { text = "📝", texthl = "DapLogPoint",    linehl = "", numhl = "" })

			dap.configurations.c = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						return vim.split(vim.fn.input("Arguments: "), " +")
					end,
					runInTerminal = false,
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					args = {},
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c

			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug cmd/...",
					request = "launch",
					program = function()
						return vim.fn.input("Path to main: ", vim.fn.getcwd() .. "/cmd/", "file")
					end,
					env = function()
						return load_env(vim.fn.getcwd() .. ".env")
					end,
					outputMode = "remote",
				},
			}
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		keys = {
			{ "<leader>du", function() require("dapui").toggle() end,                                        desc = "Debug: Toggle UI" },
			{ "<leader>de", function() require("dapui").eval() end,         mode = { "n", "v" },            desc = "Debug: Evaluate" },
			{ "<leader>dh", function() require("dapui").float_element("scopes", { enter = true }) end,      desc = "Debug: Hover Variables" },
			{ "<leader>dw", function() require("dapui").float_element("watches", { enter = true }) end,     desc = "Debug: Open Watches" },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

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
							{ id = "scopes",      size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks",      size = 0.25 },
							{ id = "watches",     size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl",    size = 0.5 },
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
					mappings = { close = { "q", "<Esc>" } },
				},
				windows = { indent = 1 },
			})

			dap.listeners.before.attach.dapui_config    = function() dapui.open() end
			dap.listeners.before.launch.dapui_config    = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			display_callback = function(variable, _, _, _, options)
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value
				else
					return variable.name .. " = " .. variable.value
				end
			end,
		},
	},

	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("dap")
		end,
		keys = {
			{ "<leader>ds", function() require("telescope").extensions.dap.commands() end,        desc = "Debug: Commands" },
			{ "<leader>dC", function() require("telescope").extensions.dap.configurations() end,  desc = "Debug: Configurations" },
			{ "<leader>dL", function() require("telescope").extensions.dap.list_breakpoints() end, desc = "Debug: List Breakpoints" },
			{ "<leader>dv", function() require("telescope").extensions.dap.variables() end,       desc = "Debug: Variables" },
			{ "<leader>df", function() require("telescope").extensions.dap.frames() end,          desc = "Debug: Frames" },
		},
	},
}
