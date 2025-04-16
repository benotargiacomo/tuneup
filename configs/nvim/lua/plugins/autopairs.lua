return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- Triggered when entering insert mode
	opts = {
		check_ts = true, --enable treesitter
		ts_config = {
			lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			javascript = { "template_string" }, -- don't add pairs in javascript template strings
		},
	},
}
