return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = { -- Automatically install LSPs to stdpath for neovim
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim", -- Automatically install linters and formatters
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
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					local opts = { buffer = event.buf }
					if desc then
						opts.desc = "LSP: " .. desc
					end
					vim.keymap.set(mode, keys, func, opts)
				end

				local builtin = require("telescope.builtin")
				map("K", vim.lsp.buf.hover)
				map("gd", builtin.lsp_definitions) --  To jump back, press <C-t>
				map("gD", vim.lsp.buf.declaration)
				map("gr", builtin.lsp_references)
				map("gi", builtin.lsp_implementations)
				map("gt", require("telescope.builtin").lsp_type_definitions)
				map("gh", vim.lsp.buf.signature_help)
				map("gs", builtin.lsp_document_symbols)
				map("gS", builtin.lsp_dynamic_workspace_symbols)
				map("<leader>ca", vim.lsp.buf.code_action)
				map("<leader>n", vim.lsp.buf.rename) -- Rename variable under cursor (grn)

				-- -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
				-- ---@param client vim.lsp.Client
				-- ---@param method vim.lsp.protocol.Method
				-- ---@param bufnr? integer some lsp support methods only in specific files
				-- ---@return boolean
				-- local function client_supports_method(client, method, bufnr)
				-- 	if vim.fn.has("nvim-0.11") == 1 then
				-- 		return client:supports_method(method, bufnr)
				-- 	else
				-- 		return client.supports_method(method, { bufnr = bufnr })
				-- 	end
				-- end
			end,
		})

		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local servers = {
			clangd = {},
			ts_ls = {},
			gopls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
			bashls = {},
		}

		local tools = { "prettier", "eslint_d", "shfmt", "stylua", "gopls", "goimports" }
		require("mason-tool-installer").setup({ ensure_installed = tools })

		-- local function organize_imports()
		-- 	local params = {
		-- 		command = "_typescript.organizeImports",
		-- 		arguments = { vim.api.nvim_buf_get_name(0) },
		-- 		title = "",
		-- 	}
		-- 	vim.lsp.buf.execute_command(params)
		-- end

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
