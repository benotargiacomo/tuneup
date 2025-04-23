return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- Triggered when entering insert mode
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local autopairs = require("nvim-autopairs")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		autopairs.setup({
			check_ts = true, --enable treesitter
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- don't add pairs in javascript template strings
			},
		})

		cmp.event:on("comfirm_done", cmp_autopairs.on_confirm_done())
	end,
}

