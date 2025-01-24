local autocmd = vim.api.nvim_create_autocmd
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
	clear = true,
})

autocmd({ "TextYankPost" }, {
	group = highlight_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
		})
	end,
})

-- autocmd({"BufWinEnter"}, {
--     callback = function()
--         vim.cmd("set formatoptions-=cro")
--     end
-- })
