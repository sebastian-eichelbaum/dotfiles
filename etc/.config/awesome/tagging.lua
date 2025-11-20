---------------------------------------------------------------------------------------------------
--
-- ░▀█▀░█▀█░█▀▀░█▀▀░▀█▀░█▀█░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
-- ░░█░░█▀█░█░█░█░█░░█░░█░█░█░█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
-- ░░▀░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀
--
-- Tagging setup, per-tag configuration and layout definitions
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")

local cascade = require("modules.layouts.cascade")

local config = require("config")

-- {{{ Library code. Tag handling

-- Generate Tags for a given screen
local function getLayout(layout)
    if not layout then
        return awful.layout.suit.tile
    end

    -- The user can define layouts by index:
    if type(layout) == "number" and layout <= #awful.layout.layouts then
        return awful.layout.layouts[layout]
    end

    -- Or by name
    if type(layout) == "string" then
        for i = 1, #awful.layout.layouts do
            if awful.layout.getname(awful.layout.layouts[i]) == layout then
                return awful.layout.layouts[i]
            end
        end
    end

    -- Return the value itself, hoping that it is a valid layout
    return layout
end

-- Generate a tag using a given config
local function makeTag(screen, tagCfg)
    local tag = awful.tag.add(
        -- Name
        tagCfg.name,

        -- Use the properties as given but ensure layout and screen are resolved.
        gears.table.join(tagCfg, {
            layout = getLayout(tagCfg.layout),
            screen = screen,
            selected = false,
        })
    )
    return tag
end

-- Generate Tags for a given screen
local function createTags(s)
    local si = s.index
    local cfg = {}

    -- Fallback if no tagging for this screen exists:
    if si > #config.tagging.screens then
        for i = 1, 9 do
            cfg[i] = gears.table.join(config.tagging.default, {
                name = tostring(i),
            })
        end
    else
        cfg = config.tagging.screens[si]
    end

    -- Each screen has its own tag table.
    local tags = {}
    for i = 1, #cfg do
        tags[i] = makeTag(s, cfg[i])
    end

    return tags
end
-- }}}

return {
    -- {{{ Tag setup - conmnect signals and set defaults
    setup = function()
        -- Dynamic Tagging? Filter unused tags.
        if config.tagging.hideEmpty then
            awful.widget.taglist.filter.all = awful.widget.taglist.filter.noempty
        end

        -- {{{ Tag layout
        -- Table of layouts to cover with awful.layout.inc, order matters.
        -- Default aweful layouts
        awful.layout.layouts = {
            -- awful.layout.suit.floating,

            awful.layout.suit.tile,
            awful.layout.suit.tile.left,
            awful.layout.suit.tile.bottom,

            -- awful.layout.suit.tile.top,
            -- awful.layout.suit.fair,
            -- awful.layout.suit.fair.horizontal,
            -- awful.layout.suit.spiral,
            -- awful.layout.suit.spiral.dwindle,

            awful.layout.suit.max,
            awful.layout.suit.max.fullscreen,

            -- awful.layout.suit.magnifier,
            --
            -- awful.layout.suit.corner.nw,
            -- awful.layout.suit.corner.ne,
            -- awful.layout.suit.corner.sw,
            -- awful.layout.suit.corner.se,

            cascade.tile,
        }

        -- Configure the cascade layyout.
        cascade.tile.offset_x = 0
        cascade.tile.offset_y = 128
        cascade.tile.extra_padding = 0
        --cascade.tile.nmaster       = 0
        cascade.tile.ncol = 2
        --cascade.tile.mwfact        = 0.5
        -- }}}

        -- {{{ Add tag set to each screen
        awful.screen.connect_for_each_screen(function(s)
            local tags = createTags(s)
            -- I'm sure you want to see at least one tag.
            tags[1].selected = true
        end)
        -- }}}
    end,
    -- }}}
}
