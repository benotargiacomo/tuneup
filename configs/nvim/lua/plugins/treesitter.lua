return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		-- "nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
	event = { "BufReadPre", "BufNewFile" }, -- Triggered before reading a file into buffer
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"scss",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			auto_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			autotag = { enable = true },
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = "<C-space>",
			-- 		node_incremental = "<C-space>",
			-- 		scope_incremental = false,
			-- 		node_decremental = "<bs>",
			-- 	},
			-- },
			-- textobjects = {
			-- 	move = {
			-- 		enable = true,
			-- 		goto_next_start = {
			-- 			["]f"] = "@function.outer",
			-- 			["]c"] = "@class.outer",
			-- 			["]a"] = "@parameter.inner",
			-- 		},
			-- 		goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
			-- 		goto_previous_start = {
			-- 			["[f"] = "@function.outer",
			-- 			["[c"] = "@class.outer",
			-- 			["[a"] = "@parameter.inner",
			-- 		},
			-- 		goto_previous_end = {
			-- 			["[F"] = "@function.outer",
			-- 			["[C"] = "@class.outer",
			-- 			["[A"] = "@parameter.inner",
			-- 		},
			-- 	},
			-- },
		})
	end,
}
