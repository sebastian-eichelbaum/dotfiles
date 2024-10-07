---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Remove the border for single windows/max windows
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")

local style = require("config").style

-- Remove border when only one window
local function setBorder(c)
    if style.autoBorder == nil then
        return
    end

    -- c.border_color = "#ff00ff"

    local s = awful.screen.focused()
    local layout = awful.layout.getname(awful.layout.get(s))
    local isFocussed = c == client.focus

    local noBorder =
        -- No border in those layouts
        (layout == "fullscreen" or layout == "max")
        -- The client is maximized
        or c.maximized
        -- Client is the only TILED client
        or (#s.tiled_clients == 1)

    -- Floats ALWAYS have a border
    if noBorder and not c.floating and (not c.forceBorder == true) then
        c.border_width = style.autoBorder.singleBorderWidth
        c.border_color = style.autoBorder.singleBorderColor(beautiful)
    elseif isFocussed then
        c.border_width = style.autoBorder.focusBorderWidth
        c.border_color = beautiful.border_focus
    else
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_normal
    end
end

return {
    setup = function()
        client.connect_signal("request::border", setBorder)
        client.connect_signal("property::maximized", setBorder)

        client.connect_signal("focus", setBorder)
        client.connect_signal("unfocus", setBorder)

        -- Force this for each layout change as awesome does not trigger request::border after a layout change
        tag.connect_signal("property::layout", function(t)
            for _, c in pairs(t.screen.clients) do
                setBorder(c)
            end
        end)
    end,
}
