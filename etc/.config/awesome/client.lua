---------------------------------------------------------------------------------------------------
--
-- ░█▀▀░█░░░▀█▀░█▀▀░█▀█░▀█▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
-- ░█░░░█░░░░█░░█▀▀░█░█░░█░░░░█░░░█░█░█░█░█▀▀░░█░░█░█
-- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀
--
-- Sets up all the buttons and key-bindings for clients (windows).
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")

local style = require("config").style
local modkey = require("config").modkey

-- {{{ Mouse bindings
local buttons = {
    awful.button({}, 1, function(c)
        c:activate({ context = "mouse_click" })
    end),
    awful.button({ modkey }, 1, function(c)
        c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ modkey }, 3, function(c)
        c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
}
-- }}}

-- {{{ Key bindings
local keys = {
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "c", function(c)
        c:kill()
    end, { description = "close", group = "client" }),
    awful.key(
        { modkey, "Control" },
        "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c)
        c:move_to_screen()
    end, { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, { description = "(un)maximize horizontally", group = "client" }),
}
-- }}}

return {
    -- {{{ Signals and default bindings
    setup = function()
        -- Signal function to execute when a new client appears.
        --
        -- NOTE: The rule system already allows default placement rules. This function is only used to prevent
        -- clients to be invisible after screen count change.
        client.connect_signal("manage", function(c)
            -- Set the windows at the slave,
            -- i.e. put it at the end of others instead of setting it master.
            -- if not awesome.startup then awful.client.setslave(c) end

            if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
                -- Prevent clients from being unreachable after screen count changes.
                awful.placement.no_offscreen(c)
            end
        end)

        -- Add a titlebar? Refer to the titlebar module.
        -- client.connect_signal("request::titlebars", function(c) end)

        -- Enable sloppy focus, so that focus follows mouse.
        client.connect_signal("mouse::enter", function(c)
            if c.focusFollowsMouse == false then
                return
            end
            c:emit_signal("request::activate", "mouse_enter", { raise = true })
        end)

        -- Focus
        client.connect_signal("focus", function(c)
            if style.singleOrMaxWindow == nil then
                c.border_color = beautiful.border_focus
            end
        end)

        -- Unfocus
        client.connect_signal("unfocus", function(c)
            if style.singleOrMaxWindow == nil then
                c.border_color = beautiful.border_normal
            end
        end)

        -- Default mouse bindings
        client.connect_signal("request::default_mousebindings", function()
            awful.mouse.append_client_mousebindings(buttons)
        end)

        -- Default key bindings
        client.connect_signal("request::default_keybindings", function()
            awful.keyboard.append_client_keybindings(keys)
        end)
    end,
    -- }}}
}
