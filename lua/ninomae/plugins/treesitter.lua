return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			-- Autoinstall languages that are not installed. Defaults to false
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },

			indent = { enable = true, disable = { "c", "cpp" } },

			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				"bash",
				"c",
				"css",
				"cpp",
				"dockerfile",
				"javascript",
				"json",
				"sql",
				"html",
				"gitignore",
				"go",
				"lua",
				"make",
				"markdown",
				"prisma",
				"python",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25,
				persist_queries = false,
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<CR>",
					show_help = "?",
				},
			},
		})
	end,
}
