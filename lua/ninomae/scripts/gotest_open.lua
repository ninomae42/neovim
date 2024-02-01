local get_test_file_name = function(bufnr)
	local file_name = vim.api.nvim_buf_get_name(bufnr)
	local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")

	if file_type == "go" then
		local is_test_file = file_name:match("_test.go$") ~= nil
		if is_test_file then
			return file_name
		end
		local full_path_without_extension = vim.fn.fnamemodify(file_name, ":r")
		return full_path_without_extension .. "_test.go"
	end
end

local get_source_file_name = function(bufnr)
	local file_name = vim.api.nvim_buf_get_name(bufnr)
	local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")

	if file_type == "go" then
		local is_test_file = file_name:match("_test.go$") ~= nil
		if not is_test_file then
			return file_name
		end
		local full_path_without_extension = vim.fn.fnamemodify(file_name, ":r")
		local fullpath_without_test = full_path_without_extension:gsub("_test$", "")
		return fullpath_without_test .. ".go"
	end
end

local open_file_with_split = function(file_name, split_direction)
	local commands = {
		h = ":split",
		horizontal = ":split",
		v = ":vsplit",
		vertical = ":vsplit",
		default = ":edit",
	}

	local command = commands[split_direction] or commands.default
	vim.cmd(command .. file_name)
end

local open_file = function(type, split_direction)
	-- get current buffer
	local bufnr = vim.api.nvim_get_current_buf()
	local file_name_func = type == "test" and get_test_file_name or get_source_file_name
	local file_name = file_name_func(bufnr)

	if file_name and vim.fn.filereadable(file_name) == 1 then
		print("opening: " .. file_name)
	else
		print("creating: " .. file_name)
	end

	open_file_with_split(file_name, split_direction)
end

-- set keymaps
vim.keymap.set("n", "<leader>tt", function()
	open_file("test", "")
end, { noremap = true, silent = true, desc = "open test file" })
vim.keymap.set("n", "<leader>th", function()
	open_file("test", "horizontal")
end, { noremap = true, silent = true, desc = "open test file horizontally" })
vim.keymap.set("n", "<leader>tv", function()
	open_file("test", "vertical")
end, { noremap = true, silent = true, desc = "open test file vertically" })

vim.keymap.set("n", "<leader>Tt", function()
	open_file("source", "")
end, { noremap = true, silent = true, desc = "open source file" })
vim.keymap.set("n", "<leader>Th", function()
	open_file("source", "horizontal")
end, { noremap = true, silent = true, desc = "open source file horizontally" })
vim.keymap.set("n", "<leader>Tv", function()
	open_file("source", "vertical")
end, { noremap = true, silent = true, desc = "open source file vertically" })
