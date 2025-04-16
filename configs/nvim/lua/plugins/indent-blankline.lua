return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Triggered before reading a file into buffer
	main = "ibl",
	opts = {},
}
