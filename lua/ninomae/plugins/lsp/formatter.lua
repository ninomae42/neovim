return {
	"mhartington/formatter.nvim",
	config = function()
		--local util = require('formatter.util')
		local filetypes = require("formatter.filetypes")

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = {
					filetypes.lua.stylua,
				},
				go = {
					filetypes.go.gofmt,
					filetypes.go.goimports,
					filetypes.go.goimports_reviser,
				},
				["*"] = {
					filetypes.any.remove_trailing_whitespace,
				},
			},
		})

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
