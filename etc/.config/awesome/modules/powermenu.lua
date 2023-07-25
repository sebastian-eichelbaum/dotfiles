---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Provide a simple power menu
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")

local commands = require("config").commands

-- {{{ Library: create power menu
local function createMenu()
    local base =  beautiful.iconPath .. "buttons/"

    menuitems ={}

    table.insert(menuitems, { "Sign Out", awesome.quit, base .. "system-log-out.svg" })
    table.insert(menuitems, { "Suspend", commands.sys.suspend, base .. "system-suspend.svg" })
    table.insert(menuitems, { "Hibernate", commands.sys.hibernate, base .. "system-suspend-hibernate.svg" })
    table.insert(menuitems, { "Restart", commands.sys.restart, base .. "system-reboot.svg" })
    table.insert(menuitems, { "Shutdown", commands.sys.shutdown, base .. "system-shutdown.svg" })

    return awful.menu.new( { items=menuitems } )
end
-- }}}

return {
    setup = function()
        local powerMenu = createMenu()
        awful.keyboard.append_global_keybindings({
            awful.key({ modkey,           }, "w", function () powerMenu:show() end, {description = "show main menu", group = "awesome"}),
        })
    end
}

