-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "s", "<Nop>", { silent = true })

-- widnow management
keymap.set("n", "ss", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "sx", "<cmd>close<CR>", { desc = "close current split" })

-- move windows
keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "move to down window" })
keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "move to up window" })
keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "move to right window" })

-- tab management
vim.keymap.set("n", "te", ":tabedit<Return>", { silent = true }) -- open new tab
vim.keymap.set("n", "tx", ":tabclose<Return>", { silent = true }) -- close current tab
vim.keymap.set("n", "tn", ":tabn<Return>", { silent = true }) -- go to next tab
vim.keymap.set("n", "tp", ":tabp<Return>", { silent = true }) -- go to previous tab

-- not copy on 'x'
keymap.set("n", "x", '"_x', { silent = true })

-- moving
keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })

-- write all changes to file, and close nvim
keymap.set("n", "<leader>q", ":xa<CR>", { silent = true, desc = "exit neovim" })
-- write all changes to all files
keymap.set("n", "<leader>w", ":wall<CR>", { silent = true, desc = "write all changes to all files" })
-- reload current file
keymap.set("n", "<leader>rl", "<cmd>:edit<cr>", { silent = true, desc = "[R]eload [F]ile" })

-- toggle relative and absolute line number
keymap.set("n", "<leader>tl", function()
	vim.o.relativenumber = not vim.o.relativenumber
end, { silent = true, desc = "[T]oggle relative [L]ine number" })

-- reload(execute) current file as luafile
keymap.set("n", "<leader>rs", "<cmd>luafile %<cr>", { silent = true, desc = "[R]eload [S]ource" })
