require("lazy-bootstrap")

-------------------------------------------------------------------------------
-- NeoVIM Base Configuration
-------------------------------------------------------------------------------

-- Basic VIM behavior setup
require("config.behavior")
-- Defines the looks of NeoVim
require("config.style")

------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- Load all the nice plugins and configure them
require("config.lazy")

-------------------------------------------------------------------------------
-- Extended config, depending on plugins
-------------------------------------------------------------------------------

-- Keybindings
require("config.mappings")


