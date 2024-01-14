local opt = vim.opt

-- settings for copilot
vim.g.copilot_no_tab_map = true

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- ignore case when searching
opt.hlsearch = false -- highlight search results

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- enable True Color support
vim.o.termguicolors = true
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus")

-- Save undo history
opt.undofile = true

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- no swapfile
opt.swapfile = false

-- no backup
opt.backup = false
opt.backupskip = "/tmp/*,/private/tmp/*"

-- appearance
opt.title = true
opt.scrolloff = 2
opt.cmdheight = 2
opt.laststatus = 2

-- listchars settings
vim.opt.list = true
vim.opt.listchars = { tab = "»-", trail = "-", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }
