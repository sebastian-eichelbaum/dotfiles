---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Change client opacity depending on focus/unfocus.
---------------------------------------------------------------------------------------------------

local awful = require("awful")

local style = require("config").style

return {
    setup = function()
        client.connect_signal("focus", function(c) c.opacity = style.focusOpacity end)
        client.connect_signal("unfocus", function(c) c.opacity = style.unfocusOpacity end)
    end
}

