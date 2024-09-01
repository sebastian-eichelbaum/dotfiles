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

                    map.n("<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk", icon = "", buffer = bufnr })
                    map.n("<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk", icon = "", buffer = bufnr })
                    map.v("<leader>hs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Stage hunk", icon = "", buffer = bufnr })
                    map.v("<leader>hr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset hunk", icon = "", buffer = bufnr })
                    map.n(
                        "<leader>hu",
                        gitsigns.undo_stage_hunk,
                        { desc = "Undo stage hunk", icon = "", buffer = bufnr }
                    )

                    map.n("<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer", icon = "", buffer = bufnr })
                    map.n("<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer", icon = "", buffer = bufnr })

                    map.n("<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk", icon = "", buffer = bufnr })
                    map.n("<leader>hb", function()
                        gitsigns.blame_line({ full = true })
                    end, { desc = "Blame current line", icon = "", buffer = bufnr })
                    map.n(
                        "<leader>tb",
                        gitsigns.toggle_current_line_blame,
                        { desc = "Toggle blame line", icon = "", buffer = bufnr }
                    )

                    map.n("<leader>hd", gitsigns.diffthis, { desc = "Diff this", icon = "", buffer = bufnr })
                    map.n("<leader>hD", function()
                        gitsigns.diffthis("~")
                    end, { desc = "Diff this", icon = "", buffer = bufnr })

                    map.n(
                        "<leader>td",
                        gitsigns.toggle_deleted,
                        { desc = "Toggle deleted lines", icon = "", buffer = bufnr }
                    )
                end,
            }
        end,
    },
    -- }}}
}
