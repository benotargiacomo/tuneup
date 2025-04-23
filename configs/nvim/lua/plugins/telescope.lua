return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/*",
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_width = 0.5,
					},
				},
				path_display = { "smart" },
				mappings = {
					-- <C-x>	Go to file selection as a split
					-- <C-v>	Go to file selection as a vsplit
					-- <C-u>	Scroll up in preview window
					-- <C-d>	Scroll down in preview window
					-- <C-c>	Close telescope (insert mode)
					-- <Esc>	Close telescope (in normal mode)
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
			pickers = {
				find_files = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
				grep_string = {
					theme = "ivy",
				},
				git_files = {
					theme = "ivy",
				},
				diagnostics = {
					theme = "ivy",
				},
				help_tags = {
					theme = "ivy",
				},
			},
		})

		-- Enable telescope fzf native, if installed
		pcall(require("telescope").load_extension, "fzf")

		-- Set keymaps (see :help telescope.builtin)
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<leader><leader>", builtin.buffers)
	end,
}
