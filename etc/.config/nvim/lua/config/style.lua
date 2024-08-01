-------------------------------------------------------------------------------
--
-- Style setup
--
-------------------------------------------------------------------------------

-- These settings modify how NeoVim looks and styles certain elements of its
-- TUI and the text

-- Colorscheme
vim.cmd [[colorscheme FetzDark]]

-- Line numbering
vim.opt.number = true

-- Relative line numbering?
vim.opt.relativenumber = false

-- A line for all those signs (modified, errors, ...)
vim.opt.signcolumn = "yes"

-- Have a distinct highlight for the cursor's line
vim.opt.cursorline = true

-- Do not show "Insert"/"Visual"... in the cmdline.
vim.opt.showmode = false

-- Title update -> sets the filename/mod state/... as X title
vim.opt.title = true
vim.opt.titlestring = "[%n] %<%t %m%r"

