local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath) -- Put lazy into the runtimepath for neovim

require("lazy").setup({
	spec = { {
		import = "plugins",
	} },
	defaults = {
		version = "*", -- always use the latest git commit
	},
})