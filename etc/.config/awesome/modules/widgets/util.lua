---------------------------------------------------------------------------------------------------
--
-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░
--
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local lib = require("lib")
local lain = require("lain")

-- {{{ Library: Utility code

-- Generate text markup for values with unita
local function genMarkup( text, unit, pretext )
    return lib.markup.fg( beautiful.widgets.fg.markupSide, pretext ) .. lib.markup.fg( beautiful.widgets.fg.markupMain,
                lib.markup.monospace(
                    lib.markup.bold(
                       text
                    )
                )
            )
            .. lib.markup.fg( beautiful.widgets.fg.markupSide, unit )
end

-- Updater - Takes an eval/map function, lets these function process the given ARGS and
--           creates a proper markup for a text widget. Also updates the image in an image
--           widget if provided.
local function updater(img, text, marginedText, evaluate, map, args)
    if not pcall(function()
        local v = evaluate(args)
        local mapped = map(v)

        marginedText:set_visible(mapped.value)

        local markup = ""
        if type(mapped.value) == "table" then
            for i,v in ipairs(mapped.value) do
                if i ~= 1 then
                    markup = markup .. genMarkup(mapped.value[i], mapped.unit[i], (mapped.splitter or " │ " ))
                else
                    markup = genMarkup(mapped.value[i], mapped.unit[i], "")
                end
            end
        else
            markup = genMarkup(mapped.value, mapped.unit, "")
        end
        text:set_markup(markup)
        if img then
            img:set_image(mapped.icon)
        end
    end) then
        marginedText:set_visible(false)
        text:set_markup(genMarkup("-", "", ""))
        if img then
            img:set_image(nil)
        end
    end
end


-- }}}

return {
    -- A common image+value widget - display a value and corresponding image
    imageValueWidget = {
        -- Use a shell comannd to retrieve the value
        shell = {
            make = function(cmd, evaluate, map, overrides)

                local override = overrides or {}

                -- The icon to use
                local img = wibox.widget{
                    widget = wibox.widget.imagebox,
                    image = nil,
                    resize = true,
                }

                -- Embedd in some margins
                local marginedImg = wibox.layout.margin(
                    img,
                    override.img_leftMargin or lib.dpi(1),
                    override.img_rightMargin or lib.dpi(1),
                    override.img_topMargin or lib.dpi(1),
                    override.img_bottomMargin or lib.dpi(1)
                )
                marginedImg:set_visible(not overrides.hideIcon)

                -- Use a named margin widget for text as it might be hidden if the value is nil. If
                -- only the text widget is hidden, there would still be a margin which looks off.
                local marginedText = wibox.layout.margin(nil, lib.dpi(3), lib.dpi(1), lib.dpi(1), lib.dpi(2))

                -- The actual watch widget
                local text, watch = awful.widget.watch(
                    -- Run thus
                    { awful.util.shell, "-c", cmd },
                    -- Every n seconds
                    override.timeout or 5,

                    -- Trigger this on each tineout
                    function(widget, stdout)
                        updater(img, widget, marginedText, evaluate, map, stdout)
                    end
                )

                -- Set the watch widget as the text widget in a margin
                marginedText.widget = text

                local widget = wibox.widget {
                    marginedImg,
                    marginedText,
                    layout = wibox.layout.align.horizontal
                }

                -- Set the buttons
                if type(override.buttons) == "function" then
                    widget:buttons(overrides.buttons(watch))
                else
                    widget:buttons(overrides.buttons or {})
                end

                return widget
            end
        },

        -- Use a lain widget as information source
        lain = {
            make = function(lainWidget, evaluate, map, overrides)

                local override = overrides or {}

                -- TODO: unify with the other versions. Duplicated code and missing features!

                -- The icon to use
                local img = wibox.widget{
                    widget = wibox.widget.imagebox,
                    image = nil,
                    resize = true,
                }
                
                -- Embedd in some margins
                local marginedImg = wibox.layout.margin(
                    img,
                    override.img_leftMargin or lib.dpi(1),
                    override.img_rightMargin or lib.dpi(1),
                    override.img_topMargin or lib.dpi(1),
                    override.img_bottomMargin or lib.dpi(1)
                )
                marginedImg:set_visible(not overrides.hideIcon)
 
                -- Use a named margin widget for text as it might be hidden if the value is nil. If
                -- only the text widget is hidden, there would still be a margin which looks off.
                local marginedText = wibox.layout.margin(nil, lib.dpi(3), lib.dpi(1), lib.dpi(1), lib.dpi(2))

                -- The actual watch widget
                local text = lain.widget[lainWidget]({
                    -- Every n seconds
                    timeout = override.timeout or 5,

                    -- Some widgets can notify about things. Generally, we do not need that.
                    notify = "off",

                    -- This is the acutally triggered update function.
                    -- The "parameters" it receives implicitly from its call context depend on the widget
                    settings = function()
                        updater(img, widget, marginedText, evaluate, map, nil)
                    end
                })

                -- Set the watch widget as the text widget in a margin
                marginedText.widget = text

                local widget = wibox.widget {
                    marginedImg,
                    marginedText,
                    layout = wibox.layout.align.horizontal
                }

                -- Set the buttons
                widget:buttons( overrides.buttons or {})

                return widget
            end
        }
    }
}
