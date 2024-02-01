local ftplugins = {
	go = { tabstop = 4, shiftwidth = 4, softtabstop = 4, expandtab = false },
	rust = { shiftwidth = 4, tabstop = 4, softtabstop = 4, expandtab = true },
	make = { tabstop = 4, shiftwidth = 4, softtabstop = 4, expandtab = false },
	python = { tabstop = 4, shiftwidth = 4, softtabstop = 4, expandtab = false },
	vue = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
	typescript = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
	typescriptreact = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
	javascript = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
	javascriptreact = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
	markdown = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
	graphql = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
}

for filetype, settings in pairs(ftplugins) do
	local autocmd_settings = {}
	for key, value in pairs(settings) do
		if key == "expandtab" then
			table.insert(autocmd_settings, value and "expandtab" or "noexpandtab")
		else
			table.insert(autocmd_settings, string.format("%s=%s", key, value))
		end
	end
	vim.cmd(string.format("autocmd FileType %s setlocal %s", filetype, table.concat(autocmd_settings, " ")))
end
