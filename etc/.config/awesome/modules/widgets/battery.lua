---------------------------------------------------------------------------------------------------
--
-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░
--
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local config = require("config")

local util = require("modules.widgets.util")

-- Get the icon for a certain level
local function getIcon( charging, discharging, level )
    local base =  beautiful.iconPath .. "widgets/"

    local n = ""
    local llevel = 0
    if level then
        llevel = tonumber(level)
    end

    local l = string.format("%.0f", 10 * math.floor( ( llevel / 10 ) + 0.5 ) )

    if charging and dischargin then
        n = "missing-symbolic"
    elseif not charging and not discharging then
        n = "ac"
    elseif charging then
        n = "level-" .. l ..  "-charging-symbolic"
    elseif discharging then
        n = "level-" .. l .. "-symbolic"
    end
    return base .. "battery-" .. n .. ".svg"
end

return {
    make = function(options)
        return util.imageValueWidget.shell.make(
            -- Command to query the value
            "cat /sys/class/power_supply/BAT0/status && \
             cat /sys/class/power_supply/BAT0/current_now && \
             cat /sys/class/power_supply/BAT0/voltage_now && \
             cat /sys/class/power_supply/BAT0/capacity",

            -- Evaluate the result of the call
            function(stdout)
                local result = {
                    perc = 0,
                    watt = 0,
                    charging = stdout:match("Charging"),
                    discharging = stdout:match("Discharging"),
                }

                -- Iterate the command output and calc the values
                if result.charging or result.discharging then
                    local lines = {}
                    for line in stdout:gmatch("%d+[^\r\n]+") do
                        lines[#lines + 1] = line
                    end
                    local current = (tonumber(lines[1]) or 0) / 1000000.0
                    local voltage = (tonumber(lines[2]) or 0) / 1000000.0
                    result.watt = current * voltage
                    result.perc = tonumber(lines[3]) or 0
                end

                return result
           end,

            -- And convert to some useful output
            function(v)
                local texts = nil
                if v.discharging or v.charging then
                    texts = {}
                    texts[1] = string.format("%2.0f", v.perc)
                    texts[2] = string.format("%4.1f", v.watt)
                end

                return {
                    value = texts,
                    unit = {"%", "W"},
                    -- splitter = " - ",
                    icon = getIcon( v.charging, v.discharging, v.perc )
                }
            end,

            -- Overrides for image and text widgets (margins, ...)
            gears.table.join(options or {}, {
                -- Button bindings
                buttons = {
                    awful.button( {}, 1, function () awful.spawn( config.commands.monitors.bat ) end )
                }
            })
        )
    end,
}

