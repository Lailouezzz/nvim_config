return {
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {
			broad_search = true,
			filewatching = "auto",
		},
	},
}
