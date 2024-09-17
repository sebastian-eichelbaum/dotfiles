-------------------------------------------------------------------------------
--
-- NeoVim Behavior
--
-------------------------------------------------------------------------------

-- This config tries to minimize clutter. Most settings in neovim are as I like
-- them. Only settings that differ from the default are done here.

-- {{{ General behavioral settings:

-- Ensure there is always a menu for completions
vim.opt.completeopt = "menu,menuone,longest,popup"

-- Threshold for reporting number of lines changed.
vim.opt.report = 0

-- Persist undo history
vim.opt.undofile = true

-- Ensure everything is written as UTF-8 and converted while reading
vim.opt.fileencoding = "utf-8"

-- The time to trigger swap file writes and CursorHold events. This should
-- be set to make modern plugins feel more fluid.
vim.opt.updatetime = 300

-- Clipboard: Map "+ register to the X clip buffer. Handy to paste in from X clip
vim.opt.clipboard:append "unnamedplus"

-- Use Cursor/Home/End/PgUp/PgDn + Shift to start selection
vim.opt.keymodel = "startsel"

-- Always enable folds by marker
vim.opt.foldmethod = "marker"

-- Also match <> pairs
vim.opt.matchpairs:append "<:>"

-- {{{ Shortmessages: avoid some noisy messages

-- No completion menu messages
vim.opt.shortmess:append "c"
-- No :intro message
vim.opt.shortmess:append "I"
-- No ATTENTION message for existing swap files
-- Be warned: when a VIM instance dies with unwritten
-- changes, this also prevents you from recovering!
vim.opt.shortmess:append "A"

-- }}}

-- }}}

-- {{{ Formatting: (indent, formtatoptions, tab/spaces, ...)

-- {{{ Indent:

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- ensure tabs are replaced by space
vim.opt.expandtab = true

-- Indent and automatic formatting
vim.opt.smartindent = true
--vim.opt.cindent = true

-- }}}

-- {{{ Format options

-- NOTE: Be aware that plugins/ftplugins can override these

-- Automatically wrap lines at textwidth
vim.opt.formatoptions:append "t"
-- Ensure comment-continuation
vim.opt.formatoptions:append "r"
vim.opt.formatoptions:append "o" -- also for new lines via "o"
-- Continuation for numbered lists.
vim.opt.formatoptions:append "n"

-- }}}

-- {{{ Strip white space at the end of lines when saving
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
        -- Save/restore the cursor position to avoid the cursor jumping to the
        -- beginning of the line after trim.
        local curPos = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", curPos)
    end,
})
-- }}}

-- }}}

-- {{{ Spelling:

-- By default, use english and german for spelling, allways enable spell
-- checking. Writing good code and configs also includes correct spelling!
vim.opt.spell = true
vim.opt.spelllang = "en,de"
vim.opt.spelloptions:append "camel" -- camel case detection
vim.opt.spelloptions:append "noplainbuffer" -- in buffers without syntax, do not spell check

-- }}}

-- {{{ Search:

-- In searches, match ignoring the case by default
vim.opt.ignorecase = true
-- Make search case sensitive when explicitly using upper-case letters
vim.opt.smartcase = true

-- }}}

-- {{{ Movement wrapping:

-- Follow breaks via backspace
vim.opt.whichwrap:append "b"
-- Follow breaks via space
vim.opt.whichwrap:append "s"
-- Follow breaks via cursor
vim.opt.whichwrap:append "<" -- in normal/visual
vim.opt.whichwrap:append ">"
vim.opt.whichwrap:append "]" -- in insert/replace
vim.opt.whichwrap:append "["

-- }}}

-- {{{ Input: (leader, timeouts)

-- The leader key is mapped to ",". It is the prefix for a lot of custom commands
vim.g.mapleader = ","

-- Timeout for key combinations
vim.opt.timeoutlen=500
-- Timeout for terminal keycodes. This influences ESC for example.
vim.opt.ttimeoutlen=10

-- }}}

-- {{{ Mini plugins:

-------------------------------------------------------------------------------
-- Automatically update Diff views when leaving insert mode

-- TODO: still needed?

-- vim.cmd([[
--     augroup AutoDiffUpdate
--         au!
--         autocmd InsertLeave * if &diff | diffupdate | let b:old_changedtick = b:changedtick | endif
--         autocmd CursorHold *
--             \ if &diff &&
--             \    (!exists('b:old_changedtick') || b:old_changedtick != b:changedtick) |
--             \   let b:old_changedtick = b:changedtick | diffupdate |
--             \ endif
--     augroup END
-- ]])

-- }}}
