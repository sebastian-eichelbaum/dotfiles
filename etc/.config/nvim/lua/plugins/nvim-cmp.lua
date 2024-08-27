

return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },

    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    opts = function()

        local cmp = require "cmp"
        local stringUtils = require('util.string')
        local hlUtils = require('util.highlight')

        ----------------------------------------------------------------------------------------------------------------
        -- {{{ Colors:

        -- Map Pmenu

        vim.api.nvim_set_hl(0, "CmpItemKind", { link = "PmenuKind" })
        vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Pmenu" })
        vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "PmenuExtra" })

        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", hlUtils.extended("Pmenu", {
            strikethrough = true,
            fg = hlUtils.darken(hlUtils.fg("Pmenu"), 1.5)
        }))
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Visual" })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "Visual" })


        -- -- Kinds - ordered into "meaningful" groups.
        --
        -- -- Callable things:
        -- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "FDCocSymbolCallable" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { link = "FDCocSymbolCallable" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { link = "FDCocSymbolCallable" })
        -- -- does this fit? In C++, these are namespaces
        -- vim.api.nvim_set_hl(0, "CmpItemKindModule", { link = "FDCocSymbolCallable" })
        --
        -- -- Type-like things, classes, collections, modules
        -- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { link = "FDCocSymbolType" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindClass", { link = "FDCocSymbolType" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "FDCocSymbolType" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { link = "FDCocSymbolType" })
        -- -- What is this?
        -- vim.api.nvim_set_hl(0, "CmpItemKindReference", { link = "FDCocSymbolType" })
        --
        -- -- Value-like things
        -- vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindValue", { link = "FDCocSymbolValue" })
        --
        -- -- Variable-like things
        -- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindField", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "FDCocSymbolValue" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { link = "FDCocSymbolValue" })
        --
        -- -- File stuff
        -- vim.api.nvim_set_hl(0, "CmpItemKindFile", { link = "FDCocSymbolFiles" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { link = "FDCocSymbolFiles" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { link = "FDCocSymbolFiles" })
        --
        -- -- Keywords, statements, ops
        -- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { link = "FDCocSymbolKeyword" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { link = "FDCocSymbolKeyword" })
        --
        -- --
        -- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "WTF" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindColor", { link = "WTF" })
        --
        -- }}}

        -- {{{ Icons:

        local customKindIcons = {
            -- Callable things
            Function      = "󰅲",
            Method        = "󰅩",
            Constructor   = "",

            -- Classes and Types
            Interface      = "",
            Class         = "",
            Struct        = "󰙅",
            Enum          = "",
            -- NOTE: this is a namespace in C++
            Module        = "",

            -- Value-things
            Value         = "󰎠",
            Text          = "󰉿",
            EnumMember    = "",
            TypeParameter = "",

            -- Variable things (named symbols)
            Variable      = "󰫧",
            Field         = "",
            Property      = "",
            Constant      = "󰏿",
            Event         = "",

            -- Keywords and statements
            Operator      = "󰆕",
            Keyword       = "",

            Reference     = "󰈇",
            File          = "",
            Folder        = "",
            Color         = "",
            Unit          = "",

            Snippet       = "",

            Default       = "",
        }

        -- }}}

        local options = {
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                --{ name = "cmdline" },
            }),

            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
                    col_offset = 1,
                    side_padding = 0,
                    border = {
                         " ",
                         "▁",
                         " ",
                         "▏",
                         " ",
                         "▔",
                         " ",
                         "▕",
                    }
                }),
                documentation = cmp.config.window.bordered(),
            },

            -- Format each entry in the completion menu
            formatting = {
                fields = {
                    "kind", "abbr",
                    -- The source (lsp, buffer, ...).
                    "menu"
                },

                format = function(entry, vim_item)

                    local kind = vim_item.kind or "Default"
                    local icon = customKindIcons[kind] or "?"

                    -- Completion source mapping to a sexy name

                    local menu = ({
                        buffer = "Buf",
                        path = "FS",
                        nvim_lsp = "LSP",
                        luasnip = "Snip",
                    })[entry.source.name]

                    local abbr = stringUtils.crop(vim_item.abbr,
                        -- Max width as a fraction of available columns
                        math.max(20,        -- at least 20
                            math.min(60,    -- at most 60
                            math.floor(0.40 * vim.o.columns))),
                        -- Ellipsis
                        " "
                    )

                    -- Construct the output:

                    vim_item.kind = "  " .. icon .. "  "
                    vim_item.abbr = abbr
                    vim_item.menu = " (" .. kind.. ")"
                    --vim_item.menu = " [" .. menu.. "]"

                    return vim_item
                end,
            }
        }

        -- Key mappings
        -- NOTE: cmp is an insert-mode tool! Most commands don't do anything in normal mode. Define insert-mode bindings
        -- in options.mapping, others should be defined via util.keymap
        options.mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({
                -- Set true to also accept the first match even if it is not selected
                select = false,
            }),

            -- Tabs/Shift Tab to cycle through matches OR jump through luasnip fields
            -- ["<Tab>"] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_next_item()
            --     --elseif require("luasnip").expand_or_jumpable() then
            --     --    require("luasnip").expand_or_jump()
            --     else
            --         fallback()
            --     end
            -- end, { "i", "s" }),
            -- ["<S-Tab>"] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_prev_item()
            --     --elseif require("luasnip").jumpable(-1) then
            --     --    require("luasnip").jump(-1)
            --     else
            --         fallback()
            --     end
            -- end, { "i", "s" })
        })


        local map = require("util.keymap")
        -- map.i("<C-Space>", cmp.mapping.complete() )
        ---map.i("<up>",  cmp.mapping.select_prev_item() )

        return options
    end,

}
