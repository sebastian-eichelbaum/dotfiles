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

return {
    make = function(options)
        return util.imageValueWidget.lain.make(
            -- The lain.widget to use
            "cpu",

            -- Evaluate the result of the call
            function()
                return cpu_now.usage
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = string.format("%2.0f", tonumber(v) or 0),
                    unit = "%",
                    icon = beautiful.iconPath .. "widgets/cpu.svg"
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
                    awful.button( {}, 1, function () awful.spawn( config.commands.monitors.cpu ) end )
                }
             })
        )
    end,
}

