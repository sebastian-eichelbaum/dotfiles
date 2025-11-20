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

local function cpuTimes(procStatLine)
    local at = 1
    local idle = 0
    local total = 0

    -- Inspired by widgets.cpu in https://github.com/lcpz/lain
    for field in string.gmatch(procStatLine, "[%s]+([^%s]+)") do
        -- Ref to man /proc/stat for field meanings
        -- 4 = idle, 5 = ioWait == CPU doing nothing
        if at == 4 or at == 5 then
            idle = idle + field
        end
        total = total + field
        at = at + 1
    end
    local active = total - idle
    return active, total
end

return {
    make = function(options)
        local cpu = { last_active = 0, last_total = 0, usage = 0 }
        return util.imageValueWidget.shell.make(
            -- Command to query the value
            "cat /proc/stat | grep 'cpu ' | tail -1",

            -- Evaluate the result of the call
            function(stdout)
                local active, total = cpuTimes(stdout)

                if cpu.last_active ~= active or cpu.last_total ~= total then
                    -- proc/stat data is an absolute value since boot. We need to get the difference to get a current
                    -- usage approximation.
                    local dactive = active - cpu.last_active
                    local dtotal = total - cpu.last_total
                    local usage = math.ceil(math.abs((dactive / dtotal) * 100))

                    cpu.last_active = active
                    cpu.last_total = total
                    cpu.usage = usage
                end

                return cpu.usage
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = string.format("%2.0f", tonumber(v) or 0),
                    unit = "%",
                    icon = beautiful.iconPath .. "widgets/cpu.svg",
                }
            end,

            -- Overrides for image and text widgets (margins, ...)
            gears.table.join(options or {}, {
                -- Updating every 10 sec is sufficient
                timeout = 2,

                -- Depending on the icon and its included borders, add margins to make them seem equally sized.
                img_topMargin = 2,
                img_bottomMargin = 2,

                -- Button bindings
                buttons = gears.table.join(awful.button({}, 1, function()
                    awful.spawn(config.commands.monitors.cpu)
                end)),
            })
        )
    end,
}
