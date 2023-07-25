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

-- Colors "inner_bg" id widgets for focussed clients
local function focussedClientUpdate(self, c, index, clients)
    local inner = self:get_children_by_id('inner_bg')[1]
    if client.focus == c then
        inner.bg = beautiful.palette.bg_lighter4
    else
        inner.bg = beautiful.bg_normal
    end
end


return {
    -- A classic task list with a single, distinct entry per task
    classic = {
        make = function(s, options)

            options = options or {}

            return awful.widget.tasklist {
                screen   = s,
                --filter   = awful.widget.tasklist.filter.focused,
                filter   = awful.widget.tasklist.filter.currenttags,
                buttons = {
                    awful.button({ }, 3, function (c)
                        c:activate { context = "tasklist", action = "toggle_minimization" }
                    end),
                    awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
                    awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
                },
                style    = {
                    shape_border_width = 0,
                    shape_border_color = '#777777',
                    shape  = gears.shape.rectangle,
                },
                layout   = {
                    spacing = lib.dpi(0),
                    margin = lib.dpi(0),
                    fill_space = true,
                    forced_width = options.forced_width,
                    layout  = wibox.layout.fixed.horizontal
                },

                widget_template =
                {
                    containers.templates.borderedBox(
                        {
                            {
                                {
                                    {
                                        {
                                            id     = 'icon_role',
                                            widget = wibox.widget.imagebox,
                                        },
                                        margins = lib.dpi(4),
                                        widget  = wibox.container.margin,
                                    },
                                    {
                                        forced_width = 8,
                                        widget = wibox.widget.textbox,
                                    },
                                    {
                                        id     = 'text_role',
                                        align  = "center",
                                        widget = wibox.widget.textbox,
                                    },
                                    layout = wibox.layout.fixed.horizontal,
                                },
                                top = lib.dpi(1),
                                bottom = lib.dpi(0),
                                left  = lib.dpi(5),
                                right = lib.dpi(5),
                                forced_width = lib.dpi(250),
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

                    create_callback = focussedClientUpdate,
                    update_callback = focussedClientUpdate,
                }
            }
        end
    },

    -- Shows only the focussed client in a more subtle fashion.
    focussed = {
        make = function(s, options)

            options = options or {}

            return awful.widget.tasklist {
                screen   = s,
                filter   = awful.widget.tasklist.filter.focused,
                buttons = {
                    awful.button({ }, 3, function (c)
                        c:activate { context = "tasklist", action = "toggle_minimization" }
                    end),
                    awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
                    awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
                },
                layout   = {
                    spacing = lib.dpi(0),
                    fill_space = options.fill_space,
                    forced_width = options.forced_width,
                    layout  = wibox.layout.fixed.horizontal
                },

                widget_template =
                {
                    {
                        {
                            {
                                {
                                    id     = 'icon_role',
                                    widget = wibox.widget.imagebox,
                                },
                                {
                                    forced_width = lib.dpi(8),
                                    widget = wibox.widget.textbox,
                                },
                                {
                                    id     = 'text_role',
                                    widget = wibox.widget.textbox,
                                },
                                layout = wibox.layout.fixed.horizontal,
                            },
                            left  = lib.dpi(5),
                            right = lib.dpi(5),
                            top = lib.dpi(5),
                            bottom = lib.dpi(7),
                            widget = wibox.container.margin,
                        },
                        valign = "center",
                        align = "center",
                        widget = wibox.container.place,
                    },
                    -- USe the focus color as bg?
                    -- id     = 'background_role',
                    widget = wibox.container.background,
                }
            }
        end
    },

    -- Shows only minimized clients as icons
    minimizedIcons = {
        make = function(s)
            return awful.widget.tasklist {
                screen   = s,
                filter   = awful.widget.tasklist.filter.minimizedcurrenttags,
                buttons = {
                    awful.button({ }, 1, function (c)
                        c:activate { context = "tasklist", action = "toggle_minimization" }
                    end),
                },
                layout   = {
                    spacing = 3,
                    layout  = wibox.layout.fixed.horizontal
                },
                -- Notice that there is *NO* wibox.wibox prefix, it is a template,
                -- not a widget instance.
                widget_template = {
                    {
                        {
                            {
                                {
                                    id     = 'clienticon',
                                    widget = awful.widget.clienticon,
                                },
                                valign = "center",
                                halign = "center",
                                top = lib.dpi(2),
                                bottom = lib.dpi(2),
                                left = lib.dpi(2),
                                right = lib.dpi(2),
                                widget  = wibox.container.margin
                            },
                            bg         = beautiful.palette.attention_darker1,
                            shape      = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, radius or 7) end,
                            shape_clip = true,
                            widget     = wibox.container.background,
                        },
                        valign = "center",
                        halign = "center",
                        top = lib.dpi(3),
                        bottom = lib.dpi(4),
                        left = lib.dpi(1),
                        right = lib.dpi(3),
                        widget  = wibox.container.margin                   
                    },

                    create_callback = function(self, c, index, objects) --luacheck: no unused args
                        self:get_children_by_id('clienticon')[1].client = c
                    end,
                    layout = wibox.layout.align.vertical,
                }
            }
        end
    }
}
