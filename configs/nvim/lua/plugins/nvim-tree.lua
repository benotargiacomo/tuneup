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
		{ "<leader>ef", "<cmd>NvimTreeFindFile<cr>" },
		{ "<leader>ec", "<cmd>NvimTreeCollapse<CR>" },
		{ "<leader>er", "<cmd>NvimTreeRefresh<CR>" },
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				-- adaptive_size = true,
				-- float = { enable = true },
				width = 40,
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
			filters = {
				custom = { ".DS_Store", "node_modules", ".vscode" },
				dotfiles = true,
			},
		})
	end,
}
