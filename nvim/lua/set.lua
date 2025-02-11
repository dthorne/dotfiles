-- ===================================================================
-- Editor settings
-- ===================================================================
vim.opt.numberwidth = 4
vim.opt.number = true
vim.opt.mouse = 'a'
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.wildmenu = false
vim.opt.smartcase = true

vim.cmd('silent !mkdir ~/.swap-files > /dev/null 2>&1')
vim.opt.swapfile = true
vim.opt.dir = '~/.swap-files'

vim.o.cmdheight = 3
vim.o.updatetime = 300
vim.o.signcolumn = 'number'

return {}
