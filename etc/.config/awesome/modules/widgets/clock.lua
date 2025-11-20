---------------------------------------------------------------------------------------------------
--
-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░
--
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local lib = require("lib")

local cal = require("modules.widgets.calendar")

return {

    make = function()
        local cw = cal({
            placement = "top_right",
            start_sunday = false,
            radius = 8,
            previous_month_button = 4,
            next_month_button = 5,
        })

        local clock = wibox.widget.textclock(
            lib.markup.fg("#bbbbbb", lib.markup.bold("%d.%m.%y - "))
                .. lib.markup.fg("#ffffff", lib.markup.bold("%H:%M"))
        )

        clock:connect_signal("button::press", function(_, _, _, button)
            if button == 1 then
                cw.toggle()
            end
            if button == 3 then
                cw.toggle()
            end
        end)
        return clock
    end,
}
