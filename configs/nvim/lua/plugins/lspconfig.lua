return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = { -- Automatically install LSPs to stdpath for neovim
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
		},
		"williamboman/mason-lspconfig.nvim", -- Automatically install linters and formatters
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = { -- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{
						path = "${3rd}/luv/library",
						words = { "vim%.uv" },
					},
				},
			},
		},
	},
	opts = {
		inlayHints = {
			enable = true,
		},
	},
	config = function()
		-- [[ Configure LSP ]]
		-- This function gets run when an LSP connects to a particular buffer.
		-- It sets the mode, buffer and description for us each time.
		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, {
					buffer = bufnr,
					desc = desc,
				})
			end

			local builtin = require("telescope.builtin")

			nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			nmap("gd", builtin.lsp_definitions, "Go to Definition")
			nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
			nmap("gr", builtin.lsp_references, "Go to References")
			nmap("gI", builtin.lsp_implementations, "Go to Implementation")
			nmap("<leader>dc", vim.lsp.buf.signature_help, "Signature Documentation")
			nmap("gs", builtin.lsp_document_symbols, "Document Symbols")
			nmap("gS", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
			nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			nmap("<leader>rn", vim.lsp.buf.rename, "Rename") -- Rename variable under cursor (grn)
		end

		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		-- Organize imports
		-- local function organize_imports()
		-- 	local params = {
		-- 		command = "_typescript.organizeImports",
		-- 		arguments = {vim.api.nvim_buf_get_name(0)},
		-- 	}
		-- 	vim.lsp.buf.execute_command(params)
		-- end

		local servers = {
			clangd = {},
			ts_ls = {},
			gopls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			lua_ls = {},
			bashls = {},
		}

		local tools = { "prettier", "eslint_d", "shfmt", "stylua", "gopls", "goimports" }

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Ensure the servers above are installed
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		})

		require("mason-tool-installer").setup({
			ensure_installed = tools,
		})
	end,
}
