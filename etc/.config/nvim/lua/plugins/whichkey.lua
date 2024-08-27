-------------------------------------------------------------------------------
-- Provides help for key combinations in vim
--

-- Map the color groups of WhichKey. The defaults do not match my color-scheme nicely
vim.cmd([[
    highlight default link WhichKey          Operator
    highlight default link WhichKeySeperator Normal
    highlight default link WhichKeyGroup     IncSearch
    highlight default link WhichKeyDesc      Function

    highlight default link WhichKeyIcon      Normal
]])

return {
    "folke/which-key.nvim",

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    lazy = true,
    event = "VeryLazy",

    opts = {
        -- Wait until the popup is shown:
        delay = 500,

        -- en- or disable some plugins.
        plugins = {
            -- shows a list of your marks on ' and `
            marks = true,
            -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            registers = true,

            -- show spelling hints when pressing z=
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },

            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true, -- adds help for operators like d, y, ...
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },

        win = {
            no_overlap = false,
            wo = {
                winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
            },
        },

        icons = {
            colors = false,
        },

        -- Override what triggers whichkey.
        --triggers = {
        --    { "<leader>", mode = { "n" } },
        --}
    },
}
