-------------------------------------------------------------------------------
--
-- NeoVim Style setup
--
-------------------------------------------------------------------------------

-- These settings modify how NeoVim looks and styles certain elements of its TUI

-- Should be on by default in NeoVim - use GUI colors in the terminal
vim.opt.termguicolors = true

local color = require("util/highlight")

vim.g["fetzDark_Palette"] = {
    -- Start with a decision on what will be your BG and FG.
    -- This defines the "mood" of the theme.
    bg = {"#1b1b1d", 0},
    fg = {'#e4e4e4', 0},

    -- Used to distinguish unknown highlights
    wtf = {'#ff00ff', 0},

    -- Primary color. It is used to distinguish things of structural meaning in your code. For example, statements,
    -- keywords and operators.
    primary = {'#4a88cc', 0},
    primaryVariant = {'#005f87', 0},


    -- Secondary color. It
    secondary = {'#85b038', 0},

}

-- Colorscheme
vim.cmd [[colorscheme FetzDark]]

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
