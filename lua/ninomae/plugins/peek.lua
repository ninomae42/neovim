return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function()
		local peek = require("peek")
		peek.setup({
			autoload = true,
			close_on_bdelete = true,
			syntax = true,
			theme = "dark",
			update_on_change = true,
			app = "webview",
			filetype = { "markdown" },
			throttle_at = 200000,
			throttle_time = "auto",
		})
		vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
		vim.api.nvim_create_user_command("PeekClose", peek.close, {})

		vim.keymap.set("n", "<leader>pp", peek.open, { desc = "[P]eek Preview", noremap = true, silent = true })
		vim.keymap.set("n", "<leader>pc", peek.close, { desc = "[P]eek Close", noremap = true, silent = true })
	end,
}
