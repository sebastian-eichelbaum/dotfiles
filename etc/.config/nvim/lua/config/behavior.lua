-------------------------------------------------------------------------------
--
-- NeoVim Behavior
--
-------------------------------------------------------------------------------

-- This config tries to minimize clutter. Most settings in neovim are as I like
-- them. Only settings that differ from the default are done here.

-- Ensure there is always a menu for completions
vim.opt.completeopt = "menu,menuone,longest,popup"

-- Threshold for reporting number of lines changed.
vim.opt.report = 0

-- The dir to open in the file browser.
-- TODO: still needed? File search and file browser plugins are used for this.
-- vim.opt.browsedir = "current"

-- By default, use english and german for spelling, allways enable spell
-- checking. Writing good code and configs also includes correct spelling!
vim.opt.spell = true
vim.opt.spelllang = "en,de"
vim.opt.spelloptions:append "camel" -- camel case detection
vim.opt.spelloptions:append "noplainbuffer" -- in buffers without syntax, do not spell check

-- Persist undo history
vim.opt.undofile = true

---- Avoid some noisy messages: (default: ltToOCF)
-- No completion menu messages
vim.opt.shortmess:append "c"
-- No :intro message
vim.opt.shortmess:append "I"
-- No ATTENTION message for existing swap files
-- Be warned: when a VIM instance dies with unwritten
-- changes, this also prevents you from recovering
vim.opt.shortmess:append "A"

-- Ensure everything is written as UTF-8 and converted while reading
vim.opt.fileencoding = "utf-8"

-- The time to trigger swap file writes and CursorHold events. This should
-- be set to make modern plugins feel more fluid.
vim.opt.updatetime = 300

-- Visually indent automatically broken lines to the same level as the start
-- of the line.
vim.opt.breakindent = true
vim.opt.showbreak = "···"

---- Tab
-- 4 char tab!
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- ensure tabs are replaces
vim.opt.expandtab = true

-- Show some specific special chars - tab for example. precedes/extends is
-- usefull when not wrapping long text. Indiciates continuing lines.
vim.opt.listchars = "tab:➜ ,precedes:«,extends:»"
vim.opt.list = true

-- Indent and automatic formatting
vim.opt.smartindent = true
--vim.opt.cindent = true
-- Automatically wrap lines at textwidth
vim.opt.formatoptions:append "t"
-- Ensure comment-continuation
vim.opt.formatoptions:append "r"
vim.opt.formatoptions:append "o" -- also for new lines via "o"
-- Continuation for numbered lists.
vim.opt.formatoptions:append "n"


--- Search
-- In searches, match ignoring the case by default
vim.opt.ignorecase = true
-- Make search case sensitive when explicitly using upper-case letters
vim.opt.smartcase = true

--- Folds
-- Marker folding by default.
vim.opt.foldmethod = "marker"
vim.opt.foldcolumn = "1"

--- Movement
-- Follow breaks via backspace
vim.opt.whichwrap:append "b"
-- Follow breaks via space
vim.opt.whichwrap:append "s"
-- Follow breaks via cursor
vim.opt.whichwrap:append "<" -- in normal/visual
vim.opt.whichwrap:append ">"
vim.opt.whichwrap:append "]" -- in insert/replace
vim.opt.whichwrap:append "["

--- Clipboard
-- Map "+ register to the X clip buffer. Handy to paste in from X clip
vim.opt.clipboard:append "unnamedplus"

-- Use Cursor/Home/End/PgUp/PgDn + Shift to start selection
vim.opt.keymodel = "startsel"

