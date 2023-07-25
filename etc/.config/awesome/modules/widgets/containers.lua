---------------------------------------------------------------------------------------------------
--
-- ░█▀▀░█▀█░█▀█░▀█▀░█▀█░▀█▀░█▀█░█▀▀░█▀▄░█▀▀
-- ░█░░░█░█░█░█░░█░░█▀█░░█░░█░█░█▀▀░█▀▄░▀▀█
-- ░▀▀▀░▀▀▀░▀░▀░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
--
---------------------------------------------------------------------------------------------------

local gears = require("gears")
local wibox = require("wibox")

-- {{{ Templates

-- Create a box template that contains a widget.
local box = function(widget, bgColor, marginLeft, marginRight, marginTop, marginBottom, id)
    return {
        id = id,
        {
            widget,
            left   = marginLeft or 7,
            top    = marginTop or 2,
            bottom = marginBottom or 2,
            right  = marginRight or 7,
            widget = wibox.container.margin,
        },
        bg         = bgColor or "alpha",
        shape      = gears.shape.rectangle,
        shape_clip = true,
        widget     = wibox.container.background,
    }
end

-- Create a slightly rounded box that contains a widget.
local roundedBox = function(widget, bgColor, marginLeft, marginRight, marginTop, marginBottom, radius, id)
    return {
        id = id,
        {
            widget,
            left   = marginLeft or 7,
            top    = marginTop or 2,
            bottom = marginBottom or 2,
            right  = marginRight or 7,
            widget = wibox.container.margin,
        },
        bg         = bgColor or "alpha",
        shape      = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, radius or 7) end,
        shape_clip = true,
        widget     = wibox.container.background,
    }
end

-- Create a box that has distingly colored borders.
local borderedBox = function(widget, bgInner, bgOuter, marginLeft, marginRight, marginTop, marginBottom, innerId, outerId)

    local n1 = box( widget, bgInner, 0,0,0,0, innerId)
    local n2 = box( n1, bgOuter, marginLeft or 0, marginRight or 0, marginTop or 0, marginBottom or 5, outerId)
    
    return n2;
end

-- }}}

return {

    -- Widget Container Templates
    templates = {
        box = box,
        roundedBox = roundedBox,
        borderedBox = borderedBox,
    },

    -- Create a box that contains a widget.
    box = function(widget, bgColor, marginLeft, marginRight, marginTop, marginBottom, id)
        return wibox.widget(box(widget, bgColor, marginLeft, marginRight, marginTop, marginBottom, id))
    end,

    -- Create a slightly rounded box that contains a widget.
    roundedBox = function(widget, bgColor, marginLeft, marginRight, marginTop, marginBottom, radius, id)
        return wibox.widget(roundedBox(widget, bgColor, marginLeft, marginRight, marginTop, marginBottom, radius, id))
    end,

    -- Create a box that has distingly colored borders.
    borderedBox = function(widget, bgInner, bgOuter, bL, bR, bT, bB, innerId, outerId)
        return wibox.widget(borderedBox(widget, bgInner, bgOuter, bL, bR, bT, bB, innerId, outerId))
    end,
}
