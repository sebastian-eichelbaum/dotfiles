---------------------------------------------------------------------------------------------------
-- 
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Remove the border for single windows/max windows
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require "beautiful"

-- Remove border when only one window
local function setBorder(c)
    local s = awful.screen.focused()

    local layout = awful.layout.getname(awful.layout.get(s))
    
    local noBorder = 
        -- No border in those layouts
        (layout == "fullscreen" or layout == "max" ) or
        -- The client is maximized
        c.maximized or
        -- Client is the only client
        (#s.tiled_clients == 1)

    -- Floats ALWAYS have a border
    if not c.floating and noBorder then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
    end
end

return {
    setup = function()
        client.connect_signal("request::border", setBorder)
        client.connect_signal("property::maximized", setBorder)

        -- Force this for each layout change as awesome does not trigger request::border after a layout change
        tag.connect_signal("property::layout", function(t)
            for _, c in pairs(t.screen.clients) do
                setBorder(c)
            end
        end)
    end
}

