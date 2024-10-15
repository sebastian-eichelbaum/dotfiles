---------------------------------------------------------------------------------------------------
--
-- ░█░░░▀█▀░█▀▄░█▀▄░█▀█░█▀▄░█░█
-- ░█░░░░█░░█▀▄░█▀▄░█▀█░█▀▄░░█░
-- ░▀▀▀░▀▀▀░▀▀░░▀░▀░▀░▀░▀░▀░░▀░
--
-- Library functions that will be handy in the config code
---------------------------------------------------------------------------------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local array = {}

-- Test if a given thing is an array
array.isArray = function(candidate)
    return candidate ~= nil and type(candidate) == "table"
end

-- Check if an array contains a value
array.contains = function(arr, val)
    if not array.isArray(arr) then
        return false
    end

    for i = 1, #arr do
        if arr[i] == val then
            return true
        end
    end
    return false
end

return {
    -- Provide cond ? T : F like syntax
    ternary = function(cond, T, F)
        if cond then
            return T
        else
            return F
        end
    end,

    -- Ellipsize strings
    ellipsize = function(text, length)
        return (text:len() > length and length > 0) and text:sub(0, length - 3) .. "..." or text
    end,

    -- Show some message using naughty
    msg = function(msg, title)
        local naughty = require("naughty")
        naughty.notify({ title = tostring(title), text = tostring(msg) })
    end,

    -- dpi-scale the given value
    dpi = function(value)
        return dpi(value)
    end,

    -- Array tools
    array = array,

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
    },

    tags = {
        -- Get the tag associated with the ID given
        getTagByID = function(id)
            if id == nil then
                return nil
            end

            local tags = root.tags()
            for i = 1, #tags do
                if array.contains(tags[i].ids, id) then
                    return tags[i]
                end
            end

            return nil
        end,
    },
}
