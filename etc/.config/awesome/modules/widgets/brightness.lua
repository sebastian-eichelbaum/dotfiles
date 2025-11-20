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
    local base = beautiful.iconPath .. "widgets/"

    if not levelStr then
        return base .. "display-brightness-high-symbolic.svg"
    end

    local level = tonumber(levelStr)

    if level > 75 then
        return base .. "display-brightness-high-symbolic.svg"
    elseif level > 35 then
        return base .. "display-brightness-medium-symbolic.svg"
    elseif level > 4 then
        return base .. "display-brightness-low-symbolic.svg"
    end

    return base .. "display-brightness-off-symbolic.svg"
end

return {
    make = function(options)
        return util.imageValueWidget.shell.make(
            -- Command to query the value
            config.commands.light.get,

            -- Evaluate the result of the call
            function(stdout)
                return string.format("%2.0f", string.gsub(stdout, "^%s*(.-)%s*$", "%1"))
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = v or "-",
                    unit = "%",
                    icon = getIcon(v),
                }
            end,

            -- Overrides for image and text widgets (margins, ...)
            gears.table.join(options or {}, {
                -- Button bindings
                buttons = function(watch)
                    return gears.table.join(
                        awful.button({}, 4, function()
                            awful.spawn(config.commands.light.monUp)
                            watch:emit_signal("timeout")
                        end),
                        awful.button({}, 5, function()
                            awful.spawn(config.commands.light.monDown)
                            watch:emit_signal("timeout")
                        end)
                    )
                end,
            })
        )
    end,
}
