vim.opt.undofile = true

local undodir = vim.fn.stdpath('cache') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

vim.opt.undolevels = 1000

vim.opt.list = true

vim.opt.listchars = {
	tab = "→ ",
	space = "·",
	trail = "·",
	precedes = "«",
	extends = "»",
}

require("plugins")
require("plugin_config")
require("keymaps")
require("neovide_config")
require("filetype")
require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
