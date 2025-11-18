local lsp_config = require("plugin_config.lsp_config")

return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	ft = "cs",
	opts = {
		broad_search = true,  -- cherche .sln dans parents
		filewatching = "auto",
	},
}
