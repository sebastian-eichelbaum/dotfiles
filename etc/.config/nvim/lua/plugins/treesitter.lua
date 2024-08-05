-------------------------------------------------------------------------------
-- Provides extended language support
--

local cfg = {
    -- "sheerun/vim-polyglot"
    "nvim-treesitter/nvim-treesitter",

    lazy = true,
    event = { "VeryLazy" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },

    build = ":TSUpdate",

    config = function()
        require'nvim-treesitter.configs'.setup({
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = {
                -- C, CPP
                "c", "cpp", "cmake", "doxygen",

                -- GPU programming
                "glsl", -- "cuda", "opencl"

                -- Rust
                "rust",

                -- C#
                "c_sharp",

                -- Python
                "python",

                -- Webdev
                "json", "jsonc", "yaml",
                "css", "scss", "html",
                "javascript", "typescript",
                "jsdoc",
                -- "vue"

                -- Writing
                "markdown", "markdown_inline",

                -- System, Scripting, ...
                "nix",
                "bash",
                "lua", "luadoc", -- for vim, awesome, ...
                "vim", "vimdoc",
                "query", -- tree-sitter query syntax

                -- QUIRK: neovim on Nix comes with these pre-installed. This caused runtime errors from time to time
                -- (probably version mismatches). Manually installing these grammars fixes the issue by compiling them
                -- for the correct tree-sitter version delivered with this plugin.
                "bash", "c", "lua", "python", "vimdoc", "vim", "query", "markdown", "markdown_inline",
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
                enable = false
            },
        })
    end,

    --init = function()
        -- Enable folds?
        -- -> keep in mind that setting these will be saved in the view.
        --set foldmethod=expr
        --set foldexpr='v:lua.vim.treesitter.foldexpr()'
    --end,
}

return cfg
