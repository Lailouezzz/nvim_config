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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.showmode = true
vim.o.undofile = true
vim.o.expandtab = false
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.autoindent = true
vim.o.shiftround = true
vim.o.nu = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

require("lazy_plugins")
require("plugin_config")
require("keymaps")
require("neovide_config")
require("filetype")
require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
