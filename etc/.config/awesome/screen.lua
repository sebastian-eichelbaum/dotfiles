---------------------------------------------------------------------------------------------------
--
-- ░█▀▀░█▀▀░█▀▄░█▀▀░█▀▀░█▀█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
-- ░▀▀█░█░░░█▀▄░█▀▀░█▀▀░█░█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀
--
-- Setup each screen. 
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

return {
    -- {{{ Screen Signals
    setup = function()
        -- Wallpaper setup
        screen.connect_signal(
            'request::wallpaper',
            function(s)
                if beautiful.wallpaper then
                    local wallpaper = beautiful.wallpaper
                    -- If wallpaper is a function, call it with the screen
                    if type(wallpaper) == "function" then
                        wallpaper = wallpaper(s)
                    end
                    gears.wallpaper.maximized(wallpaper, s, true)
                else
                    -- Set a color as default if nothing was set
                    gears.wallpaper.set("#000000")
                end
            end
        )
    end
    -- }}}
}
