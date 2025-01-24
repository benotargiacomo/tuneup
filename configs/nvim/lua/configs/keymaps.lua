local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Copy, Paste, Delete
keymap("n", "x", '"_x') -- delete the character without yanking it into the default register.
keymap("x", "p", [["_dP]]) -- paste without yanking (delete to void register)
-- keymap({ "n", "v" }, "<leader>y", [["+y]]) -- yanks to system clipboard
-- keymap("n", "<leader>Y", [["+Y]]) -- yanks the current line to system clipboard
-- keymap({ "n", "v" }, "<leader>p", [["+p]]) -- paste from system clipboard
keymap({ "n", "v" }, "<leader>d", [["_d]]) -- delete without yanking (delete to void register)

-- Better Indentation
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<leader>v", "<C-w>v") -- split window vertically
keymap("n", "<leader>h", "<C-w>s") -- split window horizontally
keymap("n", "<leader>x", "<cmd>close<CR>") -- close current split window

-- Quick Fix
-- keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
-- keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
-- keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Buffers
-- keymap("n", "<leader>bd", "<cmd>bd<cr>", {})
-- keymap("n", "<leader>bda", "<cmd>%bd<cr>", {})
-- keymap("n", "<S-h>", "<cmd>bprevious<CR>", {})
-- keymap("n", "<S-l>", "<cmd>bnext<CR>", {})

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)

-- keymap("n", "<leader>fm", vim.lsp.buf.format)
-- keymap("n", "<leader>e", vim.cmd.Ex)

-- Others
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader>dv", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>")
keymap("n", "<leader>x", "<cmd>!node %<CR>", { silent = true })
