return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Triggered before reading a file into buffer
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = {},
			lualine_x = { "diagnostics" },
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
	},
}
