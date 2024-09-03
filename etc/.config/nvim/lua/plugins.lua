local stringUtils = require("util.string")
local hl = require("util.highlight")
local map = require("util.keymap")

return {

    -- {{{ Util: restore_view
    -- Stores and restores settings/folds/... of files
    {
        -- Automagically save/restore views
        "vim-scripts/restore_view.vim",
    },
    -- }}}

    -- {{{ Util: vim-rooter
    -- Find the project root
    {
        "notjedi/nvim-rooter.lua",

        opts = {
            -- With git submodules, .git exists as file in a submodule. To
            -- make the top-level project the project root, use ".git/"
            -- with slash to match only git dirs.
            rooter_patterns = { ".repo/", ".git/", "_darcs/", ".hg/", ".bzr/", ".svn/" },

            -- If no root is found, go to the files own dir
            fallback_to_parent = true,
        },
    },
    -- }}}

    -- {{{ Util: fzf
    -- Allows fuzzy finding files and search in files
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },

        lazy = true,
        event = "VeryLazy",

        init = function()
            vim.cmd([[

                " Move FZF down
                let g:fzf_layout = { 'down': '~40%' }

                " fzf.vim specific settings go in here
                let g:fzf_vim = {}

                " Preview window. 50 percent at the right but hide the preview if
                " Less than 70 cols are available
                let g:fzf_vim.preview_window = ['right,50%,<70(hidden)']

                " Mapping of ui elements to Highlights
                " - ref https://github.com/junegunn/fzf/blob/master/README-VIM.md
                let g:fzf_colors =
                \ {
                  "\ 'fg':      ['fg', 'Normal'],
                  "\ 'bg':      ['bg', 'Normal'],
                  "\ 'hl':      ['fg', 'Search'],
                  "\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                  \ 'bg+':     ['bg', 'Visual', 'Visual'],
                  "\ 'hl+':     ['fg', 'Search'],
                  "\ 'info':    ['fg', 'Search'],
                  "\ 'border':  ['fg', 'CursorLine'],
                  "\ 'prompt':  ['fg', 'Keyword'],
                  "\ 'pointer': ['fg', 'Keyword'],
                  "\ 'marker':  ['fg', 'Keyword'],
                  "\ 'spinner': ['fg', 'Search'],
                  "\ 'gutter':  ['bg', 'CursorLine'],
                  "\ 'header':  ['bg', 'Error']
                \ }
            ]])

            map.n("<leader>e", ":Files<CR>", { desc = "Edit file", icon = "󱇧" })
            map.n("<leader>/", ":RG<CR>", { desc = "Search in files", icon = "󰱼" })
            map.n("<leader>#", ":RG <C-R><C-W><CR>", { desc = "Search word in files", icon = "󰱼" })
        end,
    },
    -- }}}

    -- {{{ UI: nvim-web-devicons
    -- Nice icon set used by several UI plugins
    {
        "nvim-tree/nvim-web-devicons",

        lazy = true,

        opts = {
            -- globally enable different highlight colors per icon (default to true)
            -- if set to false all icons will have the default icon's color
            color_icons = false,

            -- globally enable default icons (default to false)
            -- will get overwritten by `get_icons` option
            default = true,

            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true,
        },
    },

    -- }}}

    -- {{{ UI: lualine.nvim
    -- Configurable status-line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        opts = {
            options = {
                icons_enabled = true,
                theme = {
                    normal = {
                        a = { fg = "#ffffff", bg = hl.bg("FetzDarkPrimary"), gui = "bold" },
                        b = { fg = hl.fg("StatusLine"), bg = hl.bg("StatusLine") },
                        c = { fg = hl.fg("StatusLineNC"), bg = hl.bg("StatusLineNC") },
                    },

                    insert = {
                        a = { fg = hl.fg("Visual"), bg = hl.bg("Visual"), gui = "bold" },
                    },

                    replace = {
                        a = { fg = hl.fg("Visual"), bg = hl.bg("Visual"), gui = "bold" },
                    },

                    visual = {
                        a = { fg = hl.fg("Visual"), bg = hl.bg("Visual"), gui = "bold" },
                    },

                    command = {
                        a = { fg = hl.bg("Normal"), bg = hl.fg("Search"), gui = "bold" },
                    },

                    inactive = {
                        a = { fg = hl.fg("StatusLineNC"), bg = hl.bg("StatusLineNC") },
                        b = { fg = hl.fg("StatusLineNC"), bg = hl.bg("StatusLineNC") },
                        c = { fg = hl.fg("StatusLineNC"), bg = hl.bg("StatusLineNC") },
                    },
                },

                component_separators = { left = "", right = "" },
                --section_separators = { left = '', right = ''},
                --section_separators = { left = '🭛', right = '🭋'},
            },

            sections = {
                -- Status as single letter
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            return str:sub(1, 1)
                        end,
                    },
                },

                -- Git status info
                lualine_b = {
                    {
                        "branch",
                        icon = { "", align = "left" },
                    },
                    {
                        "diff",
                        -- Re-format de detailed output to only show a small "modified" marker instead of
                        -- add/remove/change counts
                        fmt = function(str, context)
                            if str == nil or str == "" then
                                return ""
                            end
                            return ""
                        end,

                        padding = { left = 0, right = 1 },

                        -- color = { fg = '#a2bf6d', gui='bold' },
                    },
                },

                -- The bufferlist
                lualine_c = {
                    {
                        -- Add some space
                        function()
                            return [[ ]]
                        end,
                        padding = 0,
                    },
                    {
                        "buffers",

                        -- Split buffers NOT using the powerline arrows
                        section_separators = { left = "🭛", right = "" },

                        -- Use nvim-web-devicons for file icons?
                        icons_enabled = false,

                        -- filenames or a shortened path relative to the CWD
                        show_filename_only = true,

                        mode = 2, -- 0: Shows buffer name
                        -- 1: Shows buffer index
                        -- 2: Shows buffer name + buffer index
                        -- 3: Shows buffer number
                        -- 4: Shows buffer name + buffer number

                        buffers_color = {
                            active = { fg = "#dddddd", bg = "background", gui = "bold" },
                        },

                        symbols = {
                            modified = " ",
                            alternate_file = "",
                            directory = "",
                        },
                    },
                },

                lualine_x = {
                    {
                        "filetype",
                        colored = false, -- Displays filetype icon in color if set to true
                        icon_only = false, -- Display only an icon for filetype
                        icon = { align = "left" }, -- Display filetype icon on the right hand side
                    },
                    -- "vim.lsp.status()"
                },

                lualine_y = {
                    {
                        function()
                            return [[]]
                        end,
                    },
                    {
                        "encoding",
                        -- Show '[BOM]' when the file has a byte-order mark
                        show_bomb = false,

                        padding = { left = 1, right = 0 },
                    },
                    {
                        "fileformat",
                        symbols = {
                            unix = "[unix]",
                            dos = "[win]",
                            mac = "[mac]",
                        },

                        padding = { left = 0, right = 1 },
                    },
                },

                lualine_z = {
                    {
                        function()
                            return [[]]
                        end,
                        padding = { left = 1, right = 0 },
                    },

                    {
                        -- 'location' and 'progress' but with a bit nicer
                        function()
                            local line = vim.fn.line(".")
                            local col = vim.fn.charcol(".")
                            local total = vim.fn.line("$")

                            -- Handle some special cases
                            local perc = math.floor(line / total * 100)
                            if line == 1 then
                                perc = 0
                            elseif line == total then
                                perc = "100"
                            end

                            return string.format("%2d%%%% %2d/%d:%-3d", perc, line, total, col)
                        end,

                        padding = { left = 1, right = 1 },
                    },
                },
            },
        },
    },
    -- }}}

    -- {{{ UI: which-key.nvim
    -- Handy tool to list key bindings as float above the statusbar
    {
        "folke/which-key.nvim",

        dependencies = { "nvim-tree/nvim-web-devicons" },

        lazy = true,
        event = "VeryLazy",

        opts = function()
            -- Map the color groups of WhichKey. The defaults do not match my color-scheme nicely
            vim.api.nvim_set_hl(0, "WhichKey", { link = "Operator" })
            vim.api.nvim_set_hl(0, "WhichKeySeperator", { link = "Normal" })
            vim.api.nvim_set_hl(0, "WhichKeyGroup", { link = "IncSearch" })
            vim.api.nvim_set_hl(0, "WhichKeyDesc", { link = "Function" })
            vim.api.nvim_set_hl(0, "WhichKeyIcon", { link = "Normal" })

            return {
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
            }
        end,
    },
    -- }}}

    -- {{{ UI: vim-startify
    -- Start page for vim. Lists MRU, git changes, ...
    {
        "mhinz/vim-startify",

        -- Required at startup
        lazy = false,

        init = function()
            vim.cmd([[
            " Do not change dir on file selection. vim-rooter is doing it already
            let g:startify_change_to_dir = 0
            let g:startify_change_to_vcs_root = 0

            " returns all modified files of the current git repo
            " `2>/dev/null` makes the command fail quietly, so that when we are not
            " in a git repo, the list will be empty
            function! s:gitModified()
                let files = systemlist('git ls-files -m 2>/dev/null')
                return map(files, "{'line': v:val, 'path': v:val}")
            endfunction

            " same as above, but show untracked files, honouring .gitignore
            function! s:gitUntracked()
                let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
                return map(files, "{'line': v:val, 'path': v:val}")
            endfunction

            function! s:gitListCommits()
                let commits = systemlist('git log --oneline 2>/dev/null | head -n10')
                return map(commits, '{"line": v:val}')
            endfunction

            let g:startify_lists = [
                    "\ { 'type': 'files',                        'header': ['   MRU'] },
                    \ { 'type': 'dir',                          'header': ['   MRU '. getcwd()] },
                    \ { 'type': 'sessions',                     'header': ['   Sessions'] },
                    \ { 'type': function('s:gitModified'),      'header': ['   Modified'] },
                    \ { 'type': function('s:gitUntracked'),     'header': ['   Untracked'] },
                    \ { 'type': function('s:gitListCommits'),   'header': ['   Commits'] },
                    \ { 'type': 'commands',                     'header': ['   Commands'] },
                    \ ]

            let g:startify_custom_header =[
             \ '    _   _         __     ___           ',
             \ '   | \ | | ___  __\ \   / (_)_ __ ___  ',
             \ '   |  \| |/ _ \/ _ \ \ / /| | `_ ` _ \ ',
             \ '   | |\  |  __/ (_) \ V / | | | | | | |',
             \ '   |_| \_|\___|\___/ \_/  |_|_| |_| |_|',
             \ '',
             \]
        ]])
        end,
    },
    -- }}}

    -- {{{ UI: nvim-neo-tree
    -- Nice file tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

        lazy = true,
        event = { "VeryLazy" },

        opts = function()
            map.n("\\", ":Neotree toggle<CR>", { desc = "File Browser", icon = "" })

            vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { link = "Error" })
            vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "Warning" })
            vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { link = "vcsSignAdd" })
            vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { link = "vcsSignAdd" })
            -- vim.api.nvim_set_hl(0, "NeoTreeDotfile", { link = "SignifySignChange" })
            -- vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { link = "Comment" })

            return {
                close_if_last_window = true,

                -- Refer to the git page of the project. Nearly all styles and highlight groups can be modified.
                default_component_configs = {
                    container = {
                        enable_character_fade = true,
                    },
                    indent = {
                        with_expanders = true,
                    },
                    modified = {
                        symbol = "",
                        highlight = "Search",
                    },
                    name = {
                        use_git_status_colors = false,
                    },

                    git_status = {
                        symbols = {
                            -- Change type
                            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted = "", -- this can only be used in the git_status source
                            renamed = "", -- this can only be used in the git_status source
                            -- Status type - see nerd fonts box types
                            untracked = "",
                            ignored = "",
                            unstaged = "",
                            staged = "",
                            conflict = "",
                        },
                    },
                },

                filesystem = {
                    -- Make the netrw replacement full size
                    hijack_netrw_behavior = "open_current",

                    filtered_items = {
                        visible = true, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        hide_by_name = {
                            --"node_modules"
                        },
                        hide_by_pattern = { -- uses glob style patterns
                            --"*.meta",
                            --"*/src/*/tsconfig.json",
                        },
                        always_show = { -- remains visible even if other settings would normally hide it
                            --".gitignored",
                        },
                        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                            --".DS_Store",
                            --"thumbs.db"
                        },
                        never_show_by_pattern = { -- uses glob style patterns
                            --".null-ls_*",
                        },
                    },

                    follow_current_file = {
                        enabled = true, -- Focus the file of the current buffer
                        leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                    },

                    group_empty_dirs = true,
                },
            }
        end,
    },
    -- }}}

    -- {{{ UI: gitsigns.nvim
    -- Show changes and provides basic staging/diff features
    {
        "lewis6991/gitsigns.nvim",

        lazy = true,
        event = { "VeryLazy" },

        opts = function()
            local function makeSigns()
                -- ┆ ┋ ┇ ╎ ╏  ░  ▒  ▓ ▍ │ ▏
                local icon = "┆"
                return {
                    add = { text = icon },
                    change = { text = icon },
                    delete = { text = icon },
                    topdelete = { text = icon },
                    changedelete = { text = icon },
                    untracked = { text = icon },
                }
            end

            vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "vcsSignAdd" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { link = "vcsSignChange" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "vcsSignDelete" })
            vim.api.nvim_set_hl(0, "GitSignsUntracked", { link = "vcsSignAdd" })
            -- Also allows to modify staged versions, virtual lines, ...
            -- Staged versions seem to be derived automatically from the non-staged versions.

            return {
                signs = makeSigns(),
                signs_staged = makeSigns(),

                -- Different signs for staged changes?
                signs_staged_enable = true,

                -- Indicate untracked files? Gets very noisy!
                attach_to_untracked = false,

                -- Show blame info next to the line?
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`

                -- When attaching, add some key mappings
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    -- Actions
                    local map = require("util.keymap")

                    map.group("<leader>v", "Versioning", "")

                    map.n("<leader>vs", gitsigns.stage_hunk, { desc = "Stage hunk", icon = "", buffer = bufnr })
                    map.n("<leader>vr", gitsigns.reset_hunk, { desc = "Reset hunk", icon = "", buffer = bufnr })
                    map.v("<leader>vs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Stage hunk", icon = "", buffer = bufnr })
                    map.v("<leader>vr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset hunk", icon = "", buffer = bufnr })
                    map.n(
                        "<leader>vu",
                        gitsigns.undo_stage_hunk,
                        { desc = "Undo stage hunk", icon = "", buffer = bufnr }
                    )

                    map.n("<leader>vS", gitsigns.stage_buffer, { desc = "Stage buffer", icon = "", buffer = bufnr })
                    map.n("<leader>vR", gitsigns.reset_buffer, { desc = "Reset buffer", icon = "", buffer = bufnr })

                    map.n("<leader>vp", gitsigns.preview_hunk, { desc = "Preview hunk", icon = "", buffer = bufnr })
                    map.n("<leader>vb", function()
                        gitsigns.blame_line({ full = true })
                    end, { desc = "Blame current line", icon = "", buffer = bufnr })

                    map.n("<leader>vd", gitsigns.diffthis, { desc = "Diff this", icon = "", buffer = bufnr })
                    map.n("<leader>vD", function()
                        gitsigns.diffthis("~")
                    end, { desc = "Diff this", icon = "", buffer = bufnr })

                    -- Show blame info as virtual text.
                    -- Disabled: slow and not useful. Query via <leader>vb!
                    -- map.n(
                    --     "<leader>tb",
                    --     gitsigns.toggle_current_line_blame,
                    --     { desc = "Toggle blame line", icon = "", buffer = bufnr }
                    -- )
                    --
                    -- Show deleted lines as virtual text.
                    -- Disabled: Gets very messy. Use <leader>vd or vD instead.
                    -- map.n(
                    --     "<leader>td",
                    --     gitsigns.toggle_deleted,
                    --     { desc = "Toggle deleted lines", icon = "", buffer = bufnr }
                    -- )
                end,
            }
        end,
    },
    -- }}}

    -- {{{ Snippets: luasnip
    -- Snipped engine with support for several snipped types.
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
            require("luasnip").config.set_config(opts)

            -- vscode format
            require("luasnip.loaders.from_vscode").lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
            require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

            -- snipmate format
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

            -- lua format
            require("luasnip.loaders.from_lua").load()
            require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

            vim.api.nvim_create_autocmd("InsertLeave", {
                callback = function()
                    if
                        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                        and not require("luasnip").session.jump_active
                    then
                        require("luasnip").unlink_current()
                    end
                end,
            })

            -- Key mappings
        end,
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

            map.n("<leader>f", conform.format, { desc = "Format buffer", icon = "󰉼" })

            return {
                -- Refer to https://github.com/stevearc/conform.nvim

                -- You gave to tell conform which formatter to use per filetype :-(
                formatters_by_ft = {
                    -- C++ and related
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                    cmake = { "cmake_format" },

                    -- The JS/TS/... Webdev world
                    javascript = { "prettier" },
                    typesript = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    vue = { "prettier" },
                    json = { "prettier" },
                    jsonc = { "prettier" },
                    yaml = { "prettier" },
                    toml = { "prettier" },

                    -- For neovim and awesome ;-)
                    lua = { "stylua" },

                    -- Shell scripting, system stuff, ...
                    sh = { "shfmt" },
                    bash = { "shfmt" },
                    nix = { "nixfmt" },
                    python = { "isort", "black" },

                    -- Text
                    markdown = { "prettier" },
                },
            }
        end,
    },
    -- }}}

    -- {{{ Language support: Treesitter
    -- Provides AST for a lot of languages. By itself, it does not have any useful functionality. It is a
    -- requirement for a lot of tools and enhanced syntax highlighting.
    {
        "nvim-treesitter/nvim-treesitter",

        lazy = true,
        event = { "VeryLazy" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },

        build = ":TSUpdate",

        config = function()
            require("nvim-treesitter.configs").setup({
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

    -- {{{ Code-completion: nvim-cmp
    -- Implements completion using the neovim LSP
    {
        "hrsh7th/nvim-cmp",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },

        lazy = true,
        event = { "BufReadPost", "BufNewFile" },

        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local config = require("config.lsp")

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

            -- {{{ Configure the completion windows and menus
            local makeBorder = function()
                return cmp.config.window.bordered({
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
                })
            end

            local options = {
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    --{ name = "cmdline" },
                    { name = "luasnip", keyword_length = 2 },
                }),

                window = {
                    completion = makeBorder(),
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
                        local icon = config.kindIcons[kind] or "?"
                        local menu = config.sourceIcons[({
                            buffer = "buffer",
                            path = "path",
                            nvim_lsp = "lsp",
                            luasnip = "snippet",
                        })[entry.source.name] or "unknown"] or "?"

                        -- Completion source mapping to a sexy name

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
                        --vim_item.menu = " (" .. kind .. ")"
                        --vim_item.menu = ""
                        --vim_item.menu = " [" .. menu.. "]"
                        vim_item.menu = "  " .. menu

                        return vim_item
                    end,
                },

                -- Couple with luasnip
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
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
                    -- Replace the word at the cursor
                    behavior = cmp.ConfirmBehavior.Replace,
                }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
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
            local config = require("config.lsp")

            for _, lsp in pairs(config.servers) do
                require("lspconfig")[lsp].setup({
                    on_attach = function(client, bufnr)
                        config.mappings(bufnr)
                    end,

                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                })
            end
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

    -- {{{ UI: trouble.nvim - nicely show lsp and diagnostic info
    -- {
    --     "folke/trouble.nvim",
    --     opts = {}, -- for default options, refer to the configuration section for custom setup.
    --     cmd = "Trouble",
    --     keys = {
    --         {
    --             "<leader>xx",
    --             "<cmd>Trouble diagnostics toggle<cr>",
    --             desc = "Diagnostics (Trouble)",
    --         },
    --         {
    --             "<leader>xX",
    --             "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    --             desc = "Buffer Diagnostics (Trouble)",
    --         },
    --         {
    --             "<leader>cs",
    --             "<cmd>Trouble symbols toggle focus=false<cr>",
    --             desc = "Symbols (Trouble)",
    --         },
    --         {
    --             "<leader>cl",
    --             "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --             desc = "LSP Definitions / references / ... (Trouble)",
    --         },
    --         {
    --             "<leader>xL",
    --             "<cmd>Trouble loclist toggle<cr>",
    --             desc = "Location List (Trouble)",
    --         },
    --         {
    --             "<leader>xQ",
    --             "<cmd>Trouble qflist toggle<cr>",
    --             desc = "Quickfix List (Trouble)",
    --         },
    --     },
    -- },
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

    -- {{{ Code-helper: vim-doge
    {
        "sebastian-eichelbaum/vim-doge",

        build = ":call doge#install()",

        init = function() end,
    },
    -- }}}
}
