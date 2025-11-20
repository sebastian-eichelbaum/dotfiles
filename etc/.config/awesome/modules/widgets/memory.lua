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
        return util.imageValueWidget.shell.make(
            -- Command to query the value
            "cat /proc/meminfo",

            -- Evaluate the result of the call
            function(stdout)
                local mem_now = {}
                -- Iterate each line of stdout
                for line in string.gmatch(stdout, "[^\r\n]+") do
                    for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
                        if k == "MemTotal" then
                            mem_now.total = math.floor(v / 1024 + 0.5)
                        elseif k == "MemFree" then
                            mem_now.free = math.floor(v / 1024 + 0.5)
                        elseif k == "Buffers" then
                            mem_now.buf = math.floor(v / 1024 + 0.5)
                        elseif k == "Cached" then
                            mem_now.cache = math.floor(v / 1024 + 0.5)
                        elseif k == "SReclaimable" then
                            mem_now.srec = math.floor(v / 1024 + 0.5)
                        end
                    end
                end

                return mem_now.total - mem_now.free - mem_now.buf - mem_now.cache - mem_now.srec
            end,

            -- And convert to some useful output
            function(v)
                return {
                    value = string.format("%4.2f", (tonumber(v) or 0) / 1000),
                    unit = "GB",
                    icon = beautiful.iconPath .. "widgets/mem.svg",
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
                    awful.spawn(config.commands.monitors.mem)
                end)),
            })
        )
    end,
}
