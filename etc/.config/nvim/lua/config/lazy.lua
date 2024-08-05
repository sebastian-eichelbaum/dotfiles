-------------------------------------------------------------------------------
--
-- Lazy.nvim setup
--
-------------------------------------------------------------------------------

require("lazy").setup({

    -- Dangerous: YOU have to define for each plugin when to load. Tedious.
    -- For saving 50ms startup time?
    defaults = {
        -- lazy = true,
    },

    spec = {
        -- import your plugins
        { import = "plugins" },
    },

    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,

        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "FetzDark" },
    },

    -- automatically check for plugin updates
    checker = {
        enabled = false,
        notify = false,
    },

    -- automatically check for config file changes and reload the ui
    change_detection = {
        enabled = false,
        notify = false,
    },

    -- Skip old plugins
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
})
