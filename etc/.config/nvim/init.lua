-------------------------------------------------------------------------------
-- NeoVIM Base Configuration
-------------------------------------------------------------------------------

-- Basic VIM behavior setup
require("config.core.behavior")
-- Defines the looks of NeoVim
require("config.core.style")

------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- Load all the nice plugins and configure them
require("config.lazy")

-------------------------------------------------------------------------------
-- Extended config, depending on plugins
-------------------------------------------------------------------------------

-- Keybindings (wants which-key)
require("config.core.mappings")

-- Diagnostics and LSP setup and key mappings
require("config.diagnostics")
require("config.lsp")


