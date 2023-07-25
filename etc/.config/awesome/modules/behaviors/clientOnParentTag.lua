---------------------------------------------------------------------------------------------------
-- 
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Push the client to the same tag as the parent
---------------------------------------------------------------------------------------------------

local awful = require("awful")

return {
    setup = function()
        -- Open client on the same tag than parent tag
        client.connect_signal("request::tag",
            function(c)
                if c.transient_for then
                    c:move_to_tag(c.transient_for.first_tag)
                end
            end)
    end
}

