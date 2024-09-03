-------------------------------------------------------------------------------
--
-- Lazy.nvim bootstrapping
--
-------------------------------------------------------------------------------

-- SEE: https://lazy.folke.io/installation

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
--
-- Lazy.nvim setup
--
-------------------------------------------------------------------------------

require("lazy").setup({

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
