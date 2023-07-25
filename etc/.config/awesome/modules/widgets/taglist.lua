---------------------------------------------------------------------------------------------------
--
-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░
--
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")

local beautiful = require("beautiful")

-- Widget and layout library
local wibox = require("wibox")

local containers = require("modules.widgets.containers")
local lib = require("lib")

return {
    make = function(s)
        return awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            style   = {
                -- shape = gears.shape.rounded_rect
            },
            widget_template = {
                containers.templates.borderedBox(
                    {
                        {
                            {
                                {
                                    {
                                        id     = 'icon_role',
                                        widget = wibox.widget.imagebox,
                                    },
                                    margins = lib.dpi(2),
                                    widget  = wibox.container.margin,
                                },
                                {
                                    id     = 'text_role',
                                    forced_width = lib.dpi(24),
                                    align = "center",
                                    widget = wibox.widget.textbox,
                                },
                                layout = wibox.layout.fixed.horizontal,
                            },
                            top = lib.dpi(1),
                            bottom = lib.dpi(0),
                            left  = lib.dpi(15),
                            right = lib.dpi(15),
                            widget = wibox.container.margin,
                        },
                        id = "inner_bg",
                        bg = "alpha",

                        widget = wibox.container.background,
                    },
                    beautiful.bg_normal,
                    "alpha",
                    lib.dpi(0), lib.dpi(0), lib.dpi(0), lib.dpi(4),
                    "", "background_role"
                ),

                widget = wibox.container.background,
                -- Add support for hover colors and an index label
                create_callback = function(self, c3, index, objects) --luacheck: no unused args
                    local inner = self:get_children_by_id('inner_bg')[1]
                    if tag.selected then
                        inner.bg = beautiful.palette.bg_lighter4
                    else
                        inner.bg = beautiful.bg_normal
                    end
                end,
                update_callback = function(self, tag, index, tags) --luacheck: no unused args
                    local inner = self:get_children_by_id('inner_bg')[1]
                    if tag.selected then
                        inner.bg = beautiful.palette.bg_lighter4
                    else
                        inner.bg = beautiful.bg_normal
                    end
               end,
            },
            buttons = {
                awful.button({ }, 1, function(t) t:view_only() end),
                awful.button({ }, 3, awful.tag.viewtoggle),
            }

        }
    end,
}
