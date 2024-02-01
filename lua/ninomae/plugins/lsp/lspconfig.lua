return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ "williamboman/mason.nvim" },
		"williamboman/mason-lspconfig.nvim",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",

		-- Additional lua configuration, makes nvim stuff amazing
		"folke/neodev.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local neodev = require("neodev")

		-- neodev requires that make sure to setup neodev BEFORE lspconfig
		neodev.setup()
		-- meason-lspconfig requires that these setup function are called in this order
		-- before setting up the servers
		mason.setup()
		mason_lspconfig.setup()

		local servers = {
			clangd = {},
			gopls = {},
			rust_analyzer = {},
			lua_ls = {
				Lua = {
					completions = {
						callSnippet = "Replace",
					},
					-- make the LSP recognize the `vim` global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make the LSP aware of Neovim runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		}

		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				local opts = { noremap = true, silent = true }
				opts.buffer = bufnr
				if desc then
					desc = "LSP: " .. desc
				end
				opts.desc = desc
				vim.keymap.set("n", keys, func, opts)
			end

			local map = function(mode, keys, func, desc)
				local opts = { noremap = true, silent = true }
				opts.buffer = bufnr
				if desc then
					desc = "LSP: " .. desc
				end
				opts.desc = desc
				vim.keymap.set(mode, keys, func, opts)
			end

			-- set keybindings
			nmap("gr", "<cmd>Telescope lsp_references<CR>", "Show LSP References")
			nmap("gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
			nmap("gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
			nmap("gi", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")

			nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
			nmap("K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
			nmap("rn", vim.lsp.buf.rename, "[R]e[N]ame")
			nmap("<leader>rs", "<cmd>LspRestart<CR>", "[R]estart L[S]P")
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Show available code actions")

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

		-- Ensure the servers above are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})
		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					settings = servers[server_name],
					on_attach = on_attach,
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		})
	end,
}
