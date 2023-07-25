---------------------------------------------------------------------------------------------------
--
-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░
--
---------------------------------------------------------------------------------------------------

local beautiful = require("beautiful")
local gears = require("gears")

local config = require("config")

local util = require("modules.widgets.util")

-- Get the icon for a certain level
local function getIcon(level)
    local base =  beautiful.iconPath .. "widgets/"

    if not level then
        return base .. "temp.svg"
    end

    if level > 80 then
        return base .. "temp_high.svg"
    elseif level > 60 then
        return base .. "temp_mid.svg"
    elseif level > 0 then
        return base .. "temp_low.svg"
    end

    return base .. "temp.svg"
end

return {
    make = function(options)
        return util.imageValueWidget.shell.make(
            -- Command to query the value
            "sensors | grep -i package | awk '{print $4;};'",

            -- Evaluate the result of the call
            function(stdout)
                local deg = string.gsub(stdout, "%D*", "")
                return tonumber(deg) / 10
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = string.format( "%2.0f", v),
                    unit = "°C",
                    icon = getIcon(v)
                }
            end,

            -- Overrides for image and text widgets (margins, ...)
            gears.table.join(options or {}, {
                -- Depending on the icon and its included borders, add margins to make them seem equally sized.
                img_topMargin = 2,
                img_bottomMargin = 2,
            })
        )
    end
}

