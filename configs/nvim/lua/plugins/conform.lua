return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	lazy = true,
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end,
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "biome-check" },
			javascriptreact = { "prettier" },
			typescriptreact = { "biome-check" },
			css = { "biome-check" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "biome-check" },
			yaml = { "prettier" },
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			sh = { "shfmt" },
			rust = { "rust-analyzer" },
		},
	},
}
