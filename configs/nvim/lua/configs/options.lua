local opt = vim.opt

-- Text Rendering
-- opt.encoding = "utf-8" -- Self Explanatory

-- Copy/Paste
opt.clipboard = "unnamedplus" -- Allow nvim to access system clipboard (On linux, you need 'xclip' if using x11 or 'wl-copy' & 'wl-paste' if using Wayland

-- Search
-- opt.hlsearch = true -- Highlight search results
-- opt.incsearch = true -- Highlight all search results as you are typing
opt.ignorecase = true -- Ignore case for search
opt.smartcase = true -- If search is small case it's case insensitive if search term Capital Case then it's case sensitive

-- Indentation
-- opt.autoindent = true  -- New lines inherit the indentation of previous lines
opt.smartindent = true -- Does the right thing (mostly) in programs
-- opt.expandtab = true -- Convert tabs to spaces
opt.tabstop = 4 -- 4 spaces for a line indent
opt.softtabstop = 4
opt.shiftwidth = 4 -- 4 spaces indentation  when using '>>' '<<'

-- Interface
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show line numbers relative to your current line
opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
opt.wrap = false -- Disable line wrapping
opt.showtabline = 1 -- Always show tabs
opt.termguicolors = true -- Enable 24-bit RGB colors. most terminals support it. (sometime make cool changes other times cause some bugs if you ever had any  issues in colorschemes come here  first)
opt.splitright = true -- Force all vertical splits to go to the right of current window
opt.splitbelow = true -- Force all horizental splits to go below current window
opt.signcolumn = "yes" -- Always show the sign column used for many purposes like debugger icons (e.g breakpoint), mark build errors or displayversion control status
opt.completeopt = { "menu", "menuone", "noselect" } -- For completions in insert mode
opt.pumheight = 10 -- Pop up menu height
opt.fillchars:append({
	eob = " ",
	stl = " ",
})

-- Other
opt.inccommand = "split"
opt.updatetime = 50 -- Faster completion (4000ms default)
opt.backup = false --  Many online configurations recommend that
opt.swapfile = false -- Also very recommende in online configurations
opt.undofile = true -- Enable persistent undo
opt.undodir = os.getenv("HOME") .. "/.vim.undodir" --  Specifiy a directory for undo files
opt.isfname:append("@-@") -- adds the characters @, -, and @ to the list of characters already defined as valid parts of a filename

-- Netrw
vim.cmd("let g:netrw_liststyle = 3") -- Netrw tree style listing
