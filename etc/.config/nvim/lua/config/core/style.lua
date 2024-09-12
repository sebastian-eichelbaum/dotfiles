-------------------------------------------------------------------------------
--
-- NeoVim Style setup
--
-------------------------------------------------------------------------------

-- These settings modify how NeoVim looks and styles certain elements of its TUI

-- Mandatory for many modern themes and some plugins
vim.opt.termguicolors = true

-- {{{ Columns:

-- Line numbering
vim.opt.number = true

-- Relative line numbering?
vim.opt.relativenumber = false

-- A line for all those signs (modified, errors, ...)
vim.opt.signcolumn = "yes"

-- Have a column at the current textwidth. This automatically tracks the textwidth option.
vim.opt.colorcolumn = "+1"

-- Enable the fold columns
vim.opt.foldcolumn = "1"

-- }}}

-- {{{ Text:

-- Have a distinct highlight for the cursor's line
vim.opt.cursorline = true

-- Ensure a default textwidth.
vim.opt.textwidth = 120

-- Visually indent automatically broken lines to the same level as the start
-- of the line.
vim.opt.breakindent = true
vim.opt.showbreak = "···"

-- Show some specific special chars - tab for example. precedes/extends is
-- usefull when not wrapping long text. Indiciates continuing lines.
vim.opt.listchars = "tab:➜ ,precedes:«,extends:»"
vim.opt.list = true

-- }}}

-- {{{ TUI

-- Do not show "Insert"/"Visual"... in the cmdline.
vim.opt.showmode = false

-- Title update -> sets the filename/mod state/... as X title
vim.opt.title = true
vim.opt.titlestring = "[%n] %<%t %m%r"

-- {{{ Highlight the yanked text
vim.cmd([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
]])

-- }}}

-- }}}
