return {
	"github/copilot.vim",
	lazy = false,
	config = function()
		local keymap = vim.keymap
		keymap.set(
			"i",
			"<C-l>",
			'copilot#Accept("<CR>")',
			{ silent = true, expr = true, script = true, replace_keycodes = false }
		)
		keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
		keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
		keymap.set("i", "<C-o>", "<Plug>(copilot-dismiss)")
		keymap.set("i", "<C-s>", "<Plug>(copilot-suggest)")
	end,
}
