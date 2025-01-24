return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<C-n>", "<cmd>NvimTreeToggle<CR>" },
		{ "<leader>ee", "<cmd>NvimTreeToggle<CR>" },
		{ "<leader>ec", "<cmd>NvimTreeCollapse<CR>" },
		{ "<leader>er", "<cmd>NvimTreeRefresh<CR>" },
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				width = 30,
				relativenumber = true,
			},
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
					quit_on_open = true,
				},
			},
			git = {
				ignore = false,
			},
		})
	end,
}
