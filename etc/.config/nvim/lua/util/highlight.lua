local tableUtils = require("util.table")

local M = {}

-- Get the given attribute of a hl group or a default if not found
local function getHLAttr(group, attr, default)
    local matched = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
    if matched == nil then
        return default
    end
    return matched
end

-- Convert the given color in RGB (0-255) to a hex color. Colors outside the range are clamped.
local function toHexColor(r, g, b)
    local function clamp(val)
        return math.floor(math.min(math.max(val, 0), 255))
    end

    local result = "#" .. string.format("%06x", clamp(r) * 0x10000 + clamp(g) * 0x100 + clamp(b)):gsub("0x", "")
    -- print(r, ", ", g, ", ", b, " == ", result)
    return result
end

-- Convert RGB to hex but tries to preserve the HUE. Ideal for brightness-scaling colors
local function toHexColor_huePreserving(r, g, b)
    -- Taken from https://stackoverflow.com/questions/141855/programmatically-lighten-a-color

    local threshold = 255.999
    local m = math.max(r, g, b)
    if m <= threshold then
        return toHexColor(r, g, b)
    end

    local total = r + g + b
    if total >= 3 * threshold then
        return toHexColor(threshold, threshold, threshold)
    end

    local x = (3 * threshold - total) / (3 * m - total)
    local gray = threshold - x * m
    return toHexColor(gray + x * r, gray + x * g, gray + x * b)
end

-- Get the foreground color of a given group
M.fg = function(group)
    return getHLAttr(group, "fg#", "#ff00ff")
end

-- Get the foreground color of a given group
M.bg = function(group)
    return getHLAttr(group, "bg#", "#ff00ff")
end

-- Fetch a given group and extend by the given set of attributed. This can be seen as creating a derivation.
-- The extended group is not added automatically. Instead, the group's options get returned. Put them into the
-- correct API calls like `vim.api.nvim_set_hl`
M.extended = function(hlName, opts)
    local def = vim.api.nvim_get_hl(0, {
        id = vim.fn.synIDtrans(vim.fn.hlID(hlName)),
        create = false,
    })

    return tableUtils.merge(def or {}, opts or {})
end

-- Link the given target group to the source
M.link = function(target, source)
    vim.api.nvim_set_hl(0, target, { link = source })
end

-- Set a given highlight to a group. The highlight is flattened before applying it. This allows merging multiple
-- highlights.
M.set = function(group, highlight)
    vim.api.nvim_set_hl(0, group, tableUtils.flatten(highlight))
end

-- Clear all defined highlights.
M.clear = function()
    vim.cmd([[
        highlight! clear
    ]])
end

M.toRGB = function(hexColor)
    local num = tonumber(hexColor:gsub("#", ""), 16)

    return {
        r = math.floor(num / 0x10000),
        g = (math.floor(num / 0x100) % 0x100),
        b = (num % 0x100),
    }
end

-- Lighten the given hex color by a given relative scale. This scales the color and returns the darker, hue-preserving
-- color.
M.lighten = function(hexColor, s)
    if hexColor == nil or hexColor == "" then
        return hexColor
    end

    local color = M.toRGB(hexColor)

    return toHexColor_huePreserving(color.r * s, color.g * s, color.b * s)
end

-- Darken the given hex color by a given relative scale. This scales the color and returns the darker, hue-preserving
-- color.
M.darken = function(hexColor, s)
    return M.lighten(hexColor, 1 / s)
end

-- Blend between two given colors
M.blend = function(hexColor1, hexColor2, s)
    local color1 = M.toRGB(hexColor1)
    local color2 = M.toRGB(hexColor2)

    return toHexColor((color1.r + color2.r) * s, (color1.g + color2.g) * s, (color1.b + color2.b) * s)
end

M.lightnessRamp = function(hexColor)
    return {
        L5 = M.lighten(hexColor, 1 + 13 * 0.22),
        L4 = M.lighten(hexColor, 1 + 9 * 0.22),
        L3 = M.lighten(hexColor, 1 + 5 * 0.22),
        L2 = M.lighten(hexColor, 1 + 3 * 0.22),
        L1 = M.lighten(hexColor, 1 + 1.33 * 0.22),
        O = hexColor,
        D1 = M.darken(hexColor, 1 + 0.66 * 0.22),
        D2 = M.darken(hexColor, 1 + 3 * 0.22),
        D3 = M.darken(hexColor, 1 + 5 * 0.22),
        D4 = M.darken(hexColor, 1 + 9 * 0.22),
        D5 = M.darken(hexColor, 1 + 13 * 0.22),
    }
end

return M
