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
local modkey = require("config").modkey

-- {{{ Library: create power menu
local function createMenu()
    local base = beautiful.iconPath .. "buttons/"

    local menuitems = {}

    table.insert(menuitems, {
        "Sign Out",
        function()
            awesome.quit(0)
        end,
        base .. "system-log-out.svg",
    })
    table.insert(menuitems, { "Suspend", commands.sys.suspend, base .. "system-suspend.svg" })
    table.insert(menuitems, { "Hibernate", commands.sys.hibernate, base .. "system-suspend-hibernate.svg" })
    table.insert(menuitems, { "Restart", commands.sys.restart, base .. "system-reboot.svg" })
    table.insert(menuitems, { "Shutdown", commands.sys.shutdown, base .. "system-shutdown.svg" })

    return awful.menu.new({ items = menuitems })
end
-- }}}

return {
    setup = function()
        local powerMenu = createMenu()
        root.keys(awful.util.table.join(
            root.keys(),
            awful.key({ modkey }, "w", function()
                powerMenu:show()
            end, { description = "show power menu", group = "awesome" })
        ))
    end,
}
