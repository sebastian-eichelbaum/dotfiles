-- Common options for each map
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-------------------------------------------------------------------------------
-- Base Setup
--

-- The leader key is mapped to ",". It is the prefix for a lot of custom commands
vim.g.mapleader = ","

-- Timeout for key combinations
vim.opt.timeoutlen=1000
-- Timeout for terminal keycodes. This influences ESC for example.
vim.opt.ttimeoutlen=10

-------------------------------------------------------------------------------
-- Annoyances
--

-- Quite often I hit q before ":" - although I want ":q" - this opens the
-- command history window. This eliminates that. Open History via Ctrl-f
keymap("n", "q:", "<nop>")

-------------------------------------------------------------------------------
-- Movement
--

-- Modern Home: jump to the first non-whitespace character in a line or to its
-- beginning.
keymap("n", "<Home>", ":call ExtendedHome()<CR>", opts)
keymap("i", "<Home>", "<C-O>:call ExtendedHome()<CR>", opts)
keymap("v", "<Home>", "<C-O>:call ExtendedHome()<CR>", opts)

-------------------------------------------------------------------------------
-- Buffers
--

-- Switch buffers via leader-tab
keymap("n", "<leader><s-tab>", "<ESC>:bprevious!<CR>", opts)
keymap("n", "<leader><tab>", "<ESC>:bnext!<CR>", opts)

-- Fast write and close
keymap("n", "<leader>w", ":update<CR>", opts)
keymap("n", "<leader>q", ":call QuitIfLastBuffer()<CR>", opts)
keymap("n", "<leader>Q", ":qa<CR>", opts)


-------------------------------------------------------------------------------
-- Search and highlight
--

-- Like */# but directly jump to the next result
--keymap("n", "*", "*``", opts)
--keymap("n", "#", "#``", opts)

-- Close match highlights
keymap("n", "<leader><ESC>", ":nohlsearch<CR>", opts)


-------------------------------------------------------------------------------
-- Utility
--

-- Using DEL to delete lines in normal mode should not put the deleted content
-- into the PRIMARY/SECONDARY clipboard. Avoids a lot of clip entries when using
-- DEL.
keymap("n", "<Del>", '"0x', opts)

-- Allow pasting into the command prompt (must not be silent)
keymap("c", "<c-v>", '<c-r>+', { noremap = true, silent = false })

-- Switch spell languages
keymap("n", "<leader>s", ":call ToggleSpell()<CR>", opts)

