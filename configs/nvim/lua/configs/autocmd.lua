local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = augroup("yankhighlight", { clear = true })
autocmd({ "TextYankPost" }, {
	group = highlight_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
		})
	end,
})

local customGroup = augroup("customGroup", {})
autocmd({ "BufWritePre" }, {
	group = customGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})