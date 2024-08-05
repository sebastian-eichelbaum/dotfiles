-------------------------------------------------------------------------------
--
-- Style setup
--
-------------------------------------------------------------------------------

-- These settings modify how NeoVim looks and styles certain elements of its
-- TUI and the text

-- Colorscheme
vim.cmd [[colorscheme FetzDark]]
-- Should be on by default in NeoVim - use GUI colors in the terminal
vim.opt.termguicolors = true

-- Line numbering
vim.opt.number = true

-- Relative line numbering?
vim.opt.relativenumber = false

-- A line for all those signs (modified, errors, ...)
vim.opt.signcolumn = "yes"

-- Have a column at the current textwidth. This automatically tracks the textwidth option.
vim.opt.colorcolumn = "+0"

-- Have a distinct highlight for the cursor's line
vim.opt.cursorline = true

-- Do not show "Insert"/"Visual"... in the cmdline.
vim.opt.showmode = false

-- Title update -> sets the filename/mod state/... as X title
vim.opt.title = true
vim.opt.titlestring = "[%n] %<%t %m%r"

-- Ensure a default textwidth.
vim.opt.textwidth = 120
