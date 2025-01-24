return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- enable snippets on
		luasnip.filetype_extend("javascript", { "html" })
		luasnip.filetype_extend("typescript", { "html", "javascript" })
		luasnip.filetype_extend("javascriptreact", { "html", "javascript" })
		luasnip.filetype_extend("typescriptreact", { "html", "javascript" })

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.config.setup({})

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			-- configure how nvim-cmp interacts with snippet engine
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item({}),
				["<C-n>"] = cmp.mapping.select_prev_item({}),
				["<C-j>"] = cmp.mapping.select_next_item({}),
				["<C-p>"] = cmp.mapping.select_next_item({}),
				["<C-b>"] = cmp.mapping.scroll_docs(-1),
				["<C-f>"] = cmp.mapping.scroll_docs(1),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
					{ "i", "c" },
				}),
				["<C-y>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
					{ "i", "c" },
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- sources for autocompletion
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system path
			},
		})
	end,
}
