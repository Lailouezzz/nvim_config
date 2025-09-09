vim.opt.undofile = true

local undodir = vim.fn.stdpath('cache') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

vim.opt.undolevels = 1000

require("plugins")
require("plugin_config")
require("keymaps")
require("neovide_config")
require("filetype")
