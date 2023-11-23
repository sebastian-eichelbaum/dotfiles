---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░░░░░░░█░█░▀█▀░█▀▄░█▀█░█▀▄
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀░░▀░░░░█▄█░░█░░█▀▄░█▀█░█▀▄
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀░▀░▀▀▀░▀▀░░▀░▀░▀░▀
--
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")

local wibox = require("wibox")

local beautiful = require("beautiful")

local lib = require("lib")
local containers = require("modules.widgets.containers")
local tasklistWidget = require("modules.widgets.tasklist")
local taglistWidget = require("modules.widgets.taglist")

local widgets = {
    clock = require("modules.widgets.clock"),
    volume = require("modules.widgets.volume"),
    brightness = require("modules.widgets.brightness"),
    battery = require("modules.widgets.battery"),
    temperature = require("modules.widgets.temperature"),
    memory = require("modules.widgets.memory"),
    cpu = require("modules.widgets.cpu"),
}

local widgetContainer = function(widget, bg)
    -- Nothing at all
    return
        containers.box(
            widget,
            "transparent",
            lib.dpi(6), lib.dpi(5), lib.dpi(6), lib.dpi(6)
        )

    -- box-style?
    --[[return
        containers.box(
            widget,
            bg,
            lib.dpi(9), lib.dpi(9), lib.dpi(6), lib.dpi(6)
        )
    --]]

    -- borderdBox-style?
    --[[return
        containers.borderedBox(
            wibox.layout.margin(widget, lib.dpi(8), lib.dpi(8), lib.dpi(6), lib.dpi(6)),
            beautiful.palette.bg,
            bg,
            lib.dpi(0), lib.dpi(0), lib.dpi(0), lib.dpi(4)
        )--]]

    -- Pill-style?
    --[[return wibox.layout.margin(
        containers.roundedBox(
            widget,
            bg
            -- Clock specific?
            -- , lib.dpi(9), lib.dpi(9), lib.dpi(1), lib.dpi(1)

        ),
        lib.dpi(3), lib.dpi(3), lib.dpi(3), lib.dpi(5))
    --]]
end

local makeSpacer = function(width)
    return
        containers.box(
           nil,
           "transparent",
           lib.dpi(0), lib.dpi(5), lib.dpi(0), lib.dpi(0)
       )
end

return {
    -- {{{ Setup client titlebars
    setup = function()
        screen.connect_signal("request::desktop_decoration", function(s)

            -- {{{ Base widgets

            -- Create an imagebox widget which will contain an icon indicating which layout we're using.
            -- We need one layoutbox per screen.
            local layoutBox = containers.roundedBox(
                awful.widget.layoutbox {
                    screen  = s,
                    buttons = {
                        awful.button({ }, 1, function () awful.layout.inc( 1) end),
                        awful.button({ }, 3, function () awful.layout.inc(-1) end),
                    }
                },
                --beautiful.palette.bg_lighter3,
                "alpha",
                lib.dpi(10), lib.dpi(10), lib.dpi(3), lib.dpi(3)
            )

            -- Create a taglist and tasklist widget
            local taglist = taglistWidget.make(s)
            local tasklist = tasklistWidget.focussed.make(s, {
                    -- The tasklist should be strechted in the middle of the screen. If the task name is very long, this will overflow and look strange.
                    -- Setting a max width avoids that.
                    fill_space = true,
                    forced_width = s.geometry.width * 0.35
            })

            local tasklistMinimized = tasklistWidget.minimizedIcons.make(s)

            -- Clock
            local clock = widgetContainer(
                widgets.clock.make(),
                beautiful.widgets.bg.clock
            )

            -- Systray
            beautiful.systray_icon_spacing = lib.dpi(8)
            beautiful.bg_systray = beautiful.widgets.bg.systrayBuiltin
            local systray = widgetContainer(
                wibox.widget.systray(),
                beautiful.widgets.bg.systray
            )
            -- }}}

            -- {{{ Additional Widgets - seperate
            local volume = widgetContainer(
                widgets.volume.make({ hideText = true }),
                "#555"
                --beautiful.widgets.bg.volume
            )

            local brightness = widgetContainer(
                widgets.brightness.make({ hideText = true }),
                "#555"
                --beautiful.widgets.bg.brightness
            )

            local battery = widgetContainer(
                widgets.battery.make(),
                beautiful.widgets.bg.battery
            )

            local monitors = widgetContainer(
                wibox.widget {
                    widgets.cpu.make({hideIcon = false}),
                    widgets.memory.make({hideIcon = true}),
                    --widgets.temperature.make({hideIcon = false}),
                    --widgets.brightness.make(),
                    --widgets.volume.make(),
                    --widgets.battery.make(),

                    spacing = lib.dpi(20),
                    spacing_widget = {
                        {
                            markup = lib.markup.fg( "#888888", "│"),
                            align = "center",
                            widget = wibox.widget.textbox,
                        },
                        widget = wibox.container.background,
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                --beautiful.widgets.bg.monitors
                "#444"
            )
            -- }}}

            -- The actual contents
            local wiboxContent = {
                layout = wibox.layout.align.horizontal,

                -- This forces the center widget to the center of the screen. But this causes one issue:
                -- if the center widget keeps growing and growing, it will push away the left/right widgets.
                -- To handle that, the middle widget is wrapped by a constraint container
                expand = "none",

                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,

                    wibox.layout.margin(taglist, lib.dpi(0), lib.dpi(0), lib.dpi(0), lib.dpi(0)),
                    wibox.layout.margin(layoutBox, lib.dpi(10), lib.dpi(10), lib.dpi(3), lib.dpi(5)),

                    tasklistMinimized,
                },

                -- Middle widget
                wibox.layout.margin(tasklist, lib.dpi(15), lib.dpi(15), lib.dpi(0), lib.dpi(0)),

                { -- Right widgets

                    layout = wibox.layout.fixed.horizontal,


                    -- The common monitor widgets
                    -- Use different containers per widget:

                    monitors,
                    battery,

                    brightness,
                    volume,

                    systray,
                    clock,

                    makeSpacer(1),

              },
            }

            -- This could be nested to add colored borders and such things.
            -- local n1 = containers.box( wiboxContent, beautiful.bg_normal, 0,0,0,0)
            -- local n2 = containers.box( n1, beautiful.border_focus, 0,0,0,3)

            -- Create the wibox
            s.mywibox = awful.wibar {
                screen   = s,

                position = "top",
                height = beautiful.wibox_height,

                widget = wiboxContent,
            }
        end)
    end
}
