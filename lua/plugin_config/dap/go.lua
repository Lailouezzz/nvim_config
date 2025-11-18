local dap = require("dap")

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
