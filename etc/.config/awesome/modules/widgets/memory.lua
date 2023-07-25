---------------------------------------------------------------------------------------------------
--
-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░
--
---------------------------------------------------------------------------------------------------

local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local config = require("config")

local util = require("modules.widgets.util")
local lib = require("lib")

return {
    make = function(options)
        return util.imageValueWidget.lain.make(
            -- The lain.widget to use
            "mem",

            -- Evaluate the result of the call
            function()
                return mem_now.used
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = string.format( "%4.2f", (tonumber(v) or 0) / 1000 ),
                    unit = "GB",
                    icon = beautiful.iconPath .. "widgets/mem.svg"
                }
            end,

            -- Overrides for image and text widgets (margins, ...)
            gears.table.join(options or {}, {
                 -- Updating every 10 sec is sufficent
                timeout = 2,

                -- Depending on the icon and its included borders, add margins to make them seem equally sized.
                img_topMargin = 2,
                img_bottomMargin = 2,

                -- Button bindings
                buttons = {
                    awful.button( {}, 1, function () awful.spawn( config.commands.monitors.mem ) end )
                }
           })
        )
    end,
}
