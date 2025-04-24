local map = require("util.keymap")
local helper = require("util.helpers")

-------------------------------------------------------------------------------
-- Annoyances
--

-- Quite often I hit q before ":" - although I want ":q" - this opens the
-- command history window. This eliminates that. Open History via Ctrl-f
map.n( "q:", "<nop>")

-------------------------------------------------------------------------------
-- Movement
--

-- Modern Home: jump to the first non-whitespace character in a line or to its
-- beginning.
map.n("<Home>", ":call ExtendedHome()<CR>")
map.i("<Home>", "<C-O>:call ExtendedHome()<CR>")
-- map.v("<Home>", "<C-O>:call ExtendedHome()<CR>") -- Not working?

-------------------------------------------------------------------------------
-- Buffers
--

-- Switch buffers via leader-tab
map.n("<leader><s-tab>", "<ESC>:bprevious!<CR>", { desc = "Prev buffer", icon = "󰓩" })
map.n("<leader><tab>", "<ESC>:bnext!<CR>", { desc = "Next buffer", icon = "󰓩" } )

-- Fast write and close
map.n("<leader>w", ":update<CR>", { desc = "Write file", icon = "󰆓" })
map.n("<leader>q", helper.closeBuffer, { desc = "Quit", icon = "󰈆" })
map.n("<leader>Q", ":qa<CR>", { desc = "Quit all", icon ="󰈆" })


-------------------------------------------------------------------------------
-- Search and highlight
--

-- Close match highlights
map.n("<leader><ESC>", ":nohlsearch<CR>", { desc = "Clear match highlights", icon = "" })

-------------------------------------------------------------------------------
-- Utility
--

-- Using DEL to delete lines in normal mode should not put the deleted content
-- into the PRIMARY/SECONDARY clipboard. Avoids a lot of clip entries when using
-- DEL.
map.n("<Del>", '"0x')

-- Allow pasting into the command prompt (must not be silent)
map.c("<c-v>", '<c-r>+', { silent = false })

-- Switch spell languages
map.n("<leader>s", ":call ToggleSpell()<CR>", { desc = "Switch spell lang", icon = "" })


-- {{{ Utility functions used in these mappings

-------------------------------------------------------------------------------
-- Jump to the first non-whitespace character in a line, or to the beginning
-- of a line
vim.cmd([[
    function ExtendedHome()
        let column = col('.')
        normal! ^
        if column == col('.')
            normal! 0
        endif
    endfunction
]])

-------------------------------------------------------------------------------
-- Switch de/en/none spelllang
vim.cmd([[
    function! ToggleSpell()
        if &spell
            if &spelllang == "de"
                set spelllang=de,en
                echo "toggle spell" &spelllang
            elseif &spelllang == "de,en"
                set spelllang=en
                echo "toggle spell" &spelllang
            else
                set spell!
                echo "toggle spell off"
            endif
        else
            set spelllang=de
            set spell!
            echo "toogle spell" &spelllang
        endif
    endfunction
]])

-- }}}
