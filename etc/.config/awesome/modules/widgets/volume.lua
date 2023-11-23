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

-- Get the icon for a certain level
local function getIcon(levelStr)
    local base =  beautiful.iconPath .. "widgets/"

    if not levelStr then
        return base .. "audio-volume-medium.svg"
    end

    level = tonumber(levelStr)

    if level > 75 then
        return base .. "audio-volume-high.svg"
    elseif level > 35 then
        return base .. "audio-volume-medium.svg"
    elseif level > 0 then
        return base .. "audio-volume-low.svg"
    end

    return base .. "audio-volume-muted.svg"
end

return {
   make = function(options)
        return util.imageValueWidget.shell.make(
            -- Command to query the value
            config.commands.volume.get,

            -- Evaluate the result of the call
            function(stdout)
                return string.format( "%2.0f", string.gsub(stdout, "^%s*(.-)%s*$", "%1") )
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = v or "-",
                    unit = "%",
                    icon = getIcon(v)
                }
            end,

            -- Overrides for image and text widgets (margins, ...)
            gears.table.join(options or {}, {

                -- Button bindings
                buttons = function(watch)
                    return {
                        awful.button( {}, 3, function () awful.spawn(config.commands.volume.mixer); watch:emit_signal("timeout") end ),
                        awful.button( {}, 1, function () awful.spawn(config.commands.volume.mute); watch:emit_signal("timeout") end ),
                        awful.button( {}, 4, function () awful.spawn(config.commands.volume.up); watch:emit_signal("timeout") end ),
                        awful.button( {}, 5, function () awful.spawn(config.commands.volume.down); watch:emit_signal("timeout") end ),
                    }
                end
            })
        )
    end
}
