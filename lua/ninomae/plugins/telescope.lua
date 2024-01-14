return {
    'nvim-telescope/telescope.nvim',
    dependencies ={
        'nvim-lua/plenary.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
        -- file icons
        'nvim-tree/nvim-web-devicons',
        -- file browser
        'nvim-telescope/telescope-file-browser.nvim',
		-- Zoxide
		{
			"jvgrootveld/telescope-zoxide",
			dependencies = {
				"nvim-lua/popup.nvim",
			},
		},
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
		local actions = require("telescope.actions")
        local fb_actions = require('telescope._extensions.file_browser.actions')

		local z_utils = require("telescope._extensions.zoxide.utils")

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { height = 0.95, prompt_position = "top" },
                sorting_strategy = "ascending",

                mappings = {
                    n = {
                        ["q"] = actions.close,
                    },
                },
                wrap_results = true,
            },
            extensions = {
                file_browser = {
					layout_strategy = "horizontal",
					layout_config = { height = 0.95, prompt_position = "top" },
					sorting_strategy = "ascending",
					initial_mode = "normal",
                    respect_gitignore = false,
					hidden = { file_browser = true, folder_browser = true },
					grouped = true,

                    hijack_netrw = true,
					mappings = {
						["i"] = {
                            ["<C-w>"] = fb_actions.backspace,
                        },
						["n"] = {
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
                },
				zoxide = {
					prompt_title = "Change Directory",
					mappings = {
						default = {
							after_action = function(selection)
								print("Update to (" .. selection.z_score .. ") " .. selection.path)
							end,
						},
						-- ["<C-s>"] = {
						-- 	before_action = function(selection)
						-- 		print("before C-s")
						-- 	end,
						-- 	action = function(selection)
						-- 		vim.cmd.edit(selection.path)
						-- 	end,
						-- },
						-- Opens the selected entry in a new split
						["<C-q>"] = { action = z_utils.create_basic_command("split") },
					},
				},
            },
        })

        -- load extentions
        telescope.load_extension('fzf')
        telescope.load_extension('file_browser')
        telescope.load_extension('zoxide')

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord under cursor" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		keymap.set(
			"n",
            "<leader>/",
			builtin.current_buffer_fuzzy_find,
			{ desc = "[/] Fuzzily find in current buffer", silent = true }
		)
		keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files", silent = true })

		keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })

		keymap.set("n", "<leader>fm", builtin.keymaps, { desc = "[F]ind key [M]ap" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })

		-- file browser
		keymap.set("n", "<leader>fb", function()
			require("telescope").extensions.file_browser.file_browser({
				hidden = true,
				cwd = vim.fn.expand("%:p:h"),
			})
		end, { noremap = true, silent = true, desc = "[F]ile [B]rowser" })

		-- zoxide
		keymap.set("n", "<leader>cd", function()
			require("telescope").extensions.zoxide.list({})
		end, { noremap = true, silent = true, desc = "[C]hange [D]irectory" })
    end,
}
