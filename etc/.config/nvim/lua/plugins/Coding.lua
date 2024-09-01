local stringUtils = require("util.string")
local hl = require("util.highlight")
local map = require("util.keymap")

return {

    -- {{{ Language support: Treesitter
    -- Provides AST for a lot of languages. By itself, it does not have any useful functionality. It is a
    -- requirement for a lot of tools and enhanced syntax highlighting.
    {
        -- "sheerun/vim-polyglot"
        "nvim-treesitter/nvim-treesitter",

        lazy = true,
        event = { "VeryLazy" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },

        build = ":TSUpdate",

        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = {
                    -- C, CPP
                    "c",
                    "cpp",
                    "cmake",
                    "doxygen",

                    -- GPU programming
                    "glsl", -- "cuda", "opencl"

                    -- Rust
                    "rust",

                    -- C#
                    "c_sharp",

                    -- Python
                    "python",

                    -- Webdev
                    "json",
                    "jsonc",
                    "yaml",
                    "css",
                    "scss",
                    "html",
                    "javascript",
                    "typescript",
                    "jsdoc",
                    -- "vue"

                    -- Writing
                    "markdown",
                    "markdown_inline",

                    -- System, Scripting, ...
                    "nix",
                    "bash",
                    "lua",
                    "luadoc", -- for vim, awesome, ...
                    "vim",
                    "vimdoc",
                    "query", -- tree-sitter query syntax

                    -- QUIRK: neovim on Nix comes with these pre-installed. This caused runtime errors from time to time
                    -- (probably version mismatches). Manually installing these grammars fixes the issue by compiling them
                    -- for the correct tree-sitter version delivered with this plugin.
                    "bash",
                    "c",
                    "lua",
                    "python",
                    "vimdoc",
                    "vim",
                    "query",
                    "markdown",
                    "markdown_inline",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = false,

                -- List of parsers to ignore installing (or "all")
                -- ignore_install = { },

                -- Use for highlighting additional syntax elements
                highlight = {
                    enable = true,
                },

                -- Enable to indent code.
                -- WARN: It assumes some style rules. For example, in C++, indenting in namespaces is assumed to be 0. If
                -- you type 'o' to get a new line, indentation might be off if the thing is inside an indented namespace.
                --
                -- Use smartindent and cindent. They perform equally or even better in 99.9% of the time so far.
                indent = {
                    enable = false,
                },
            })
        end,

        --init = function()
        -- Enable folds?
        -- -> keep in mind that setting these will be saved in the view.
        --set foldmethod=expr
        --set foldexpr='v:lua.vim.treesitter.foldexpr()'
        --end,
    },
    -- }}}

    -- {{{ Formatting: conform.nvim
    -- Wraps all those formatters and allow some config tweaks
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },

        opts = function()
            local conform = require("conform")
            return require("util.table").merge(
                {
                    -- Refer to https://github.com/stevearc/conform.nvim
                },
                -- All the LSP/CMP/Mason magic is in this one config
                require("config.lsp").setupConform(conform) or {}
            )
        end,
    },
    -- }}}

    -- {{{ Code-completion: nvim-cmp
    -- Implements completion using the neovim LSP
    {
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
            local cmp = require("cmp")

            ----------------------------------------------------------------------------------------------------------------
            -- {{{ Colors:

            -- Map Pmenu

            vim.api.nvim_set_hl(0, "CmpItemKind", { link = "PmenuKind" })
            vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Pmenu" })
            vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "PmenuExtra" })

            vim.api.nvim_set_hl(
                0,
                "CmpItemAbbrDeprecated",
                hl.extended("Pmenu", {
                    strikethrough = true,
                    fg = hl.darken(hl.fg("Pmenu"), 1.5),
                })
            )
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
                Function = "󰅲",
                Method = "󰅩",
                Constructor = "",

                -- Classes and Types
                Interface = "",
                Class = "",
                Struct = "󰙅",
                Enum = "",
                -- NOTE: this is a namespace in C++
                Module = "",

                -- Value-things
                Value = "󰎠",
                Text = "󰉿",
                EnumMember = "",
                TypeParameter = "",

                -- Variable things (named symbols)
                Variable = "󰫧",
                Field = "",
                Property = "",
                Constant = "󰏿",
                Event = "",

                -- Keywords and statements
                Operator = "󰆕",
                Keyword = "",

                Reference = "󰈇",
                File = "",
                Folder = "",
                Color = "",
                Unit = "",

                Snippet = "",

                Default = "",
            }
            -- }}}

            -- {{{ Configure the completion windows and menus
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
                        },
                    }),
                    documentation = cmp.config.window.bordered(),
                },

                -- Format each entry in the completion menu
                formatting = {
                    fields = {
                        "kind",
                        "abbr",
                        -- The source (lsp, buffer, ...).
                        "menu",
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

                        local abbr = stringUtils.crop(
                            vim_item.abbr,
                            -- Max width as a fraction of available columns
                            math.max(
                                20, -- at least 20
                                math.min(
                                    60, -- at most 60
                                    math.floor(0.40 * vim.o.columns)
                                )
                            ),
                            -- Ellipsis
                            " "
                        )

                        -- Construct the output:

                        vim_item.kind = "  " .. icon .. "  "
                        vim_item.abbr = abbr
                        vim_item.menu = " (" .. kind .. ")"
                        --vim_item.menu = " [" .. menu.. "]"

                        return vim_item
                    end,
                },
            }
            --- }}}

            -- {{{ Key mappings
            -- NOTE: cmp is an insert-mode tool! Most commands don't do anything in normal mode. Define insert-mode bindings
            -- in options.mapping, others should be defined via util.keymap
            options.mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
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

            -- map.i("<C-Space>", cmp.mapping.complete() )
            ---map.i("<up>",  cmp.mapping.select_prev_item() )

            --- }}}

            return options
        end,
    },
    --- }}}

    -- {{{ Code-completion: nvim-lspconfig
    -- Configures the LSP servers for neovim.
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },

        config = function()
            -- All the LSP/CMP/Mason magic is in this one config
            require("config.lsp").setupLSP(require("lspconfig"))
        end,
    },
    --- }}}

    -- {{{ Code-helper: nvim-autopairs
    -- Some magic to close braces and strings automatically
    {
        "windwp/nvim-autopairs",

        lazy = true,
        event = "InsertEnter",

        opts = {
            -- disable_filetype = { "TelescopePrompt" , "vim" },
        },
    },
    -- }}}

    -- {{{ Code-helper: nvim-ts-autotag
    -- Automatic tag pairs for xml, html, ...
    {
        "windwp/nvim-ts-autotag",

        lazy = true,
        event = { "BufReadPost", "BufNewFile" },

        opts = {
            opts = {
                -- Defaults
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false, -- Auto close on trailing </
            },

            -- Override settings:
            per_filetype = {
                --["html"] = { enable_close = false },
            },
        },
    },
    -- }}}

    -- {{{ Syntax and Style: indent-blankline.nvim
    -- Have indent level lines. Requires treesitter.
    {
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
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
        end,
    },
    -- }}}

    -- {{{ Syntax and Style: nvim-colorizer
    -- Provides coloring of hex/css colors.
    {
        "norcalli/nvim-colorizer.lua",

        lazy = true,
        event = "VeryLazy",

        init = function()
            require("colorizer").setup(
                {
                    css = {
                        css = true,
                    },
                    javascript = {},
                    vim = {},
                    html = {
                        mode = "foreground",
                    },
                },
                -- Defaults:
                {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = true, -- "Name" codes like Blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    rgb_fn = false, -- CSS rgb() and rgba() functions
                    hsl_fn = false, -- CSS hsl() and hsla() functions
                    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes: foreground, background
                    mode = "background", -- Set the display mode.
                }
            )
        end,
    },
    -- }}}
}
