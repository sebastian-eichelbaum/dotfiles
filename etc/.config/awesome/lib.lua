---------------------------------------------------------------------------------------------------
--
-- ░█░░░▀█▀░█▀▄░█▀▄░█▀█░█▀▄░█░█
-- ░█░░░░█░░█▀▄░█▀▄░█▀█░█▀▄░░█░
-- ░▀▀▀░▀▀▀░▀▀░░▀░▀░▀░▀░▀░▀░░▀░
--
-- Library functions that will be handy in the config code
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local naughty = require("naughty")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return {
    -- Provide cond ? T : F like syntax
    ternary = function( cond , T , F )
        if cond then return T else return F end
    end,

    -- Ellipsize strings
    ellipsize = function(text, length)
        return (text:len() > length and length > 0)
            and text:sub(0, length - 3) .. '...'
            or text
    end,

    -- Show some message using naughty
    msg = function(msg, title)
        naughty.notify({ title = tostring(title), text = tostring(msg) })
    end,

    -- dpi-scale the given value
    dpi = function(value)
        return dpi(value)
    end,

    -- Array tools
    array = {
        -- Check if an array contains a value
        contains = function(array, val)
            if not array then
                return false
            end

            for i=1,#array do
                if array[i] == val then
                    return true
                end
            end
            return false
        end
    },

    -- Markup similar to lain.markup - https://github.com/lcpz/lain/blob/master/util/markup.lua
    markup = {
        -- Set the foreground
        fg = function(color, text)
            return string.format("<span foreground='%s'>%s</span>", color, text)
        end,

        -- Bold text
        bold = function(text)
            return string.format("<b>%s</b>", text)
        end,

        -- Monospace text
        monospace = function(text)
            return string.format("<tt>%s</tt>", text)
        end,
    }
}
