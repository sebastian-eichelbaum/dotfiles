-------------------------------------------------------------------------------
-- Nice file tree
--

vim.cmd([[nnoremap \ :Neotree toggle<cr>]])

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    opts = {
        close_if_last_window = false,

        default_component_configs = {
            container = {
                enable_character_fade = true
            },
            indent = {
                indent_size = 2,
                padding = 1, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = "🭰" ,
                last_indent_marker = "🭰",
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰜌",
                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                -- then these will never be used.
                default = "*",
                highlight = "NeoTreeFileIcon"
            },
            modified = {
                symbol = "[+]",
                    highlight = "NeoTreeModified",
            },

            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },

            git_status = {
                symbols = {
                    -- Change type
                    added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted   = "✖",-- this can only be used in the git_status source
                    renamed   = "󰁕",-- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "󰄱",
                    staged    = "",
                    conflict  = "",
                }
            },

            -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
            file_size = {
                enabled = true,
                required_width = 64, -- min width of window required to show this column
            },
            type = {
                enabled = true,
                required_width = 122, -- min width of window required to show this column
            },
            last_modified = {
                enabled = true,
                required_width = 88, -- min width of window required to show this column
            },
            created = {
                enabled = true,
                required_width = 110, -- min width of window required to show this column
            },
            symlink_target = {
                enabled = false,
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
                enabled = true, -- This will find and focus the file in the active buffer every time
                --               -- the current file is changed while the tree is open.
                leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = true,
        }
    },
}
