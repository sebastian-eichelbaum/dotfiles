---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Change client opacity depending on focus/unfocus.
---------------------------------------------------------------------------------------------------

local awful = require("awful")

local lib = require("lib")
local config = require("config").style.autoOpacity

local function matches(c, matchSet)
    -- 1. Excluded by tag:
    if lib.array.isArray(matchSet.byTag) then
        for _, tagName in pairs(matchSet.byTag) do
            local t = lib.tags.getTagByID(tagName)
            if t ~= nil and lib.array.contains(t:clients(), c) then
                return true
            end
        end
    end

    -- 2. Exclude by layout
    if lib.array.isArray(matchSet.byLayout) then
        for _, clientTag in pairs(c:tags()) do
            if lib.array.contains(matchSet.byLayout, awful.layout.getname(clientTag.layout)) then
                return true
            end
        end
    end

    -- 3. Exclude by class
    if lib.array.contains(matchSet.byClass, c.class) or lib.array.contains(matchSet.byClass, c.instance) then
        return true
    end

    -- 4. By some props.
    if (c.maximized and matchSet.maximized) or (c.fullscreen and matchSet.fullscreen) then
        return true
    end

    return false
end

-- Update the opacity for a given client.
local function updateOpacity(c)
    if config == nil or c == nil then
        return
    end

    local set = function(o, uo)
        if c == client.focus then
            c.opacity = (o == nil and config.opacity) or o
        else
            c.opacity = (uo == nil and config.unfocusOpacity) or uo
        end
    end

    -- First of all: check exclusions.
    if matches(c, config.exclude) then
        set(1, 1)
        return
    end

    -- Any overrides?
    if lib.array.isArray(config.override) then
        for _, overr in pairs(config.override) do
            if matches(c, overr.match) then
                set(overr.opacity, overr.unfocusOpacity)
                return
            end
        end
    end

    set()
end

return {
    setup = function()
        client.connect_signal("focus", updateOpacity)
        client.connect_signal("unfocus", updateOpacity)

        -- Update on tag change.
        client.connect_signal("tagged", updateOpacity)
        client.connect_signal("untagged", updateOpacity)

        client.connect_signal("property::maximized", updateOpacity)
        client.connect_signal("property::fullscreen", updateOpacity)

        -- Update on layout change.
        tag.connect_signal("property::layout", function(t)
            for _, c in pairs(t:clients()) do
                updateOpacity(c)
            end
        end)
    end,
}
