-------------------------------------------------------------------------------
-- Provides additional language support
--

-- To disable support for some languages explicitly, list them here:
vim.g.polyglot_disabled = {
    -- 'markdown'
}

local polyglot = {
    "sheerun/vim-polyglot"
}

local treesitter = {
    -- "sheerun/vim-polyglot"
    "nvim-treesitter/nvim-treesitter",

    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },

    build = ":TSUpdate",

    config = function()
        require'nvim-treesitter.configs'.setup({
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = {
                -- neovim on Nix comes with these pre-installed. This caused runtime errors from time to time (probably
                -- version mismatches). Manually installing these fixes the issue by compiling them for the correct
                -- treesitter version delivered with this plugin.
                "bash", "c", "lua", "python", "vimdoc", "vim", "query", "markdown", "markdown_inline",

                "cpp", "cmake",
                "rust",
                "glsl",
                "c_sharp",
                "nix",
                "json", "yaml",
                "css", "scss", "html",
                "javascript",
                "typescript",
                -- "vue"
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            -- List of parsers to ignore installing (or "all")
            ignore_install = { "javascript" },

            highlight = {
                enable = true,
            },

            indent = {
                enable = true
            },
        })

        -- Enable folds?
        -- -> keep in mind that setting these will be saved in the view.
        --set foldmethod=expr
        --set foldexpr='v:lua.vim.treesitter.foldexpr()'
    end
}

return treesitter
