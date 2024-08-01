-------------------------------------------------------------------------------
-- NeoVIM Configuration
-------------------------------------------------------------------------------

-- Basic VIM behavior setup
require("config.behavior")
-- Defines the looks of NeoVim
require("config.style")
-- Keybindings
require("config.mappings")
-- Sets some very specific settings and workarounds
require("config.quirks")

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- Helpers and tiny plugins
require("miniplugs")

-- Load all the nice plugins
require("config.lazy")
