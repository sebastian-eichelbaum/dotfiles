---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Force redrawing unity if switched to a tag that has a unity client window. Unity does not
-- properly redraw its window when switching tags.
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")

-- TODO: check if still needed?

return {
    setup = function()
        -- Unity clients on a tag need to redraw. A flicker-free trick: add+remove borders.
        -- Refer to: https://forum.unity.com/threads/editor-panels-only-redraw-on-update-mouse-over.731285/
        -- Modified
        tag.connect_signal("property::selected", function(t)
            local clients = awful.client.visible(s)
            for _, client in pairs(clients) do
                if awful.rules.match(client, {class = "Unity"}) then
                    -- Modified the original hack. Setting a border and unsetting is now delayed by 1/60s as
                    -- it would conflict with the "no border on single window" behavior
                    gears.timer.start_new(1/60, function()
                        local bw = client.border_width
                        client.border_width = client.border_width + 1
                        gears.timer.start_new(1/60, function()
                            client.border_width = math.max(0, bw)
                        end)
                    end)

                    -- Flickers but works with the "no border on single window" behavior.
                    --client.fullscreen = not client.fullscreen
                    --gears.timer.start_new(1/60, function()
                    --    client.fullscreen = not client.fullscreen
                    --end)
                end
            end
        end)
    end
}

