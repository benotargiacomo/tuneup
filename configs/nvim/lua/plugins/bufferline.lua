return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>" },
		{ "[b", "<cmd>BufferLineMovePrev<cr>" },
		{ "]b", "<cmd>BufferLineMoveNext<cr>" },
	},
	opts = {
		options = {
			show_buffer_close_icons = false,
			show_close_icon = false,
		},
	},
}