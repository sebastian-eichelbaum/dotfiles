-------------------------------------------------------------------------------
-- Nice file tree
--

vim.cmd([[nnoremap \ :Neotree toggle<cr>]])

vim.cmd([[
hi! link NeoTreeGitConflict     Error

hi! link NeoTreeGitUntracked    Warning
hi! link NeoTreeGitStaged       vcsSignAdd
hi! link NeoTreeGitUnstaged     vcsSignAdd

" hi! link NeoTreeDotfile  SignifySignChange
" hi! link NeoTreeGitIgnored      Comment
]])

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    lazy = true,
    event = { "VeryLazy" },

    opts = {
        close_if_last_window = true,

        -- Refer to the git page of the project. Nearly all styles and highlight groups can be modified.
        default_component_configs = {
            container = {
                enable_character_fade = true
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
                    added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted   = "",-- this can only be used in the git_status source
                    renamed   = "",-- this can only be used in the git_status source
                    -- Status type - see nerd fonts box types
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                }
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
        }
    },
}
