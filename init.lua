local undodir = vim.fn.stdpath('cache') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir
vim.opt.undofile = true
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
vim.o.expandtab = false
vim.o.hlsearch = true
vim.o.cursorline = true
vim.o.autoindent = true
vim.o.shiftround = true
vim.o.nu = true
vim.o.winborder = "rounded"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	float = { border = "rounded" },
})

require("lazy_plugins")
require("keymaps")
require("neovide_config")
require("filetype")
require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
