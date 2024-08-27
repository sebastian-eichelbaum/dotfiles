return {
    "lukas-reineke/indent-blankline.nvim",

    main = "ibl",

    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    opts = {
        -- Indent lines
        indent = {
            -- To disable indentlines, set some BG highlight group
            -- The line char
            char = "▏",
            -- The highlight group to use
            highlight = "IndentLine",
        },

        -- Highlight the current scope?
        -- ATTENTION: this more often does not work than work. In lua, scopes of structs/array are not highlighted
        -- for example.
        scope = {
            enabled = true,
            char = "▎",
            highlight = "ScopeLine",

            -- Underline the beginning/end of the scope?
            show_start = false,
            show_end = false,
        },

        -- Alternating highlight of the indent-level background
        -- whitespace = {
        --      -- Alternate these highlights
        --      highlight = { "Normal", "CursorLine" },
        --      -- Required.
        --      remove_blankline_trail = true,
        -- },
    },

    init = function()
        -- Disable the line on level 0
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
    end,
}
