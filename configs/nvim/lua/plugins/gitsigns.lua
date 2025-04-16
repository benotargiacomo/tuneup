return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Triggered before reading a file into buffer
	opts = {
		signs = {
			-- add = { text = "+" },
			-- change = { text = "~" },
			-- delete = { text = "_" },
			-- topdelete = { text = "‾" },
			-- changedelete = { text = "~" },
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "▎" },
			topdelete = { text = "▎" },
			changedelete = { text = "▎" },
			untracked = { text = "┆ " },
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end)

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end)

			-- Actions
			-- map("v", "<leader>hs", function()
			-- 	gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			-- end)
			-- map("v", "<leader>hr", function()
			-- 	gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			-- end)
			--
			-- map("n", "<leader>hs", gitsigns.stage_hunk)
			-- map("n", "<leader>hr", gitsigns.reset_hunk)
			-- map("n", "<leader>hS", gitsigns.stage_buffer)
			-- map("n", "<leader>hu", gitsigns.stage_hunk)
			-- map("n", "<leader>hR", gitsigns.reset_buffer)
			-- map("n", "<leader>hp", gitsigns.preview_hunk)
			-- map("n", "<leader>hb", gitsigns.blame_line)
			-- map("n", "<leader>hd", gitsigns.diffthis)
			-- map("n", "<leader>hD", function()
			-- 	gitsigns.diffthis("@")
			-- end)
			-- Toggles
			-- map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
			-- map("n", "<leader>tD", gitsigns.preview_hunk_inline)
		end,
	},
}
