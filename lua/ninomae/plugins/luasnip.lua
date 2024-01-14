return {
	"L3MON4D3/LuaSnip", -- Snippet Engine
	run = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets", -- snippet collection
	},
	config = function()
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.setup({})
	end,
}
