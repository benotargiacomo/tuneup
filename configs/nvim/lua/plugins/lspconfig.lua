return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = { -- Automatically install LSPs to stdpath for neovim
		{ "williamboman/mason.nvim", cmd = "Mason" },
		"williamboman/mason-lspconfig.nvim", -- Automatically install linters and formatters
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = { -- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = {
		inlay_hints = {
			enabled = true,
			exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
		},
		-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the code lenses.
		codelens = {
			enabled = false,
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

			nmap("K", vim.lsp.buf.hover)
			nmap("gd", builtin.lsp_definitions) --  To jump back, press <C-t>
			nmap("gD", vim.lsp.buf.declaration)
			nmap("gr", builtin.lsp_references)
			nmap("gi", builtin.lsp_implementations)
			nmap("gt", require("telescope.builtin").lsp_type_definitions)
			nmap("gh", vim.lsp.buf.signature_help)
			nmap("gs", builtin.lsp_document_symbols)
			nmap("gS", builtin.lsp_dynamic_workspace_symbols)
			nmap("<leader>ca", vim.lsp.buf.code_action)
			nmap("<leader>n", vim.lsp.buf.rename) -- Rename variable under cursor (grn)
		end

		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		-- Organize imports
		local function organize_imports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
				title = "",
			}
			vim.lsp.buf.execute_command(params)
		end

		local servers = {
			clangd = {},
			ts_ls = {},
			gopls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			lua_ls = {},
			bashls = {},
			rust_analyzer = {},
		}

		local tools = { "prettier", "biome", "eslint_d", "shfmt", "stylua", "gopls", "goimports", "rust-analyzer" }

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
				local server_config = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}

				-- Only add 'commands' if the server_name is 'ts_ls'
				if server_name == "ts_ls" then
					server_config.commands = {
						OrganizeImports = {
							organize_imports,
							description = "Organize Imports",
						},
					}
				end

				-- Setup the server with the configured settings
				require("lspconfig")[server_name].setup(server_config)
			end,
		})

		require("mason-tool-installer").setup({ ensure_installed = tools })
	end,
}
