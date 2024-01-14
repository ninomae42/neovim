return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", opts = {} },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return str:sub(1, 2)
					end,
				},
			},
			lualine_b = {
				{ "branch" },
				{ "diff", colored = true },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					always_visible = true,
				},
			},
			lualine_c = { "filename" },
		},
		tabline = {
			lualine_b = {
				{
					"filetype",
					colored = true,
					icon_only = true,
					component_separators = { left = "", right = "" },
				},
				{
					"filename",
					file_status = true, -- displays file status (readonly status, modified status)
					newfile_status = true,
					path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					component_separators = { left = "", right = "" },
				},
			},
			lualine_z = { "tabs" },
		},
	},
}
