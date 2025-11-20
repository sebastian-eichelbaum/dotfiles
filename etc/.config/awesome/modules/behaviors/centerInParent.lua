---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Center a child window in its parent
---------------------------------------------------------------------------------------------------

local awful = require("awful")

return {
    setup = function()
        -- center client in parent
        -- Disable for clients using the "disallow_autocenter" propertie in its rule
        client.connect_signal("manage", function(c)
            if c.transient_for and not c.disallow_autocenter then
                c.floating = true
                awful.placement.centered(c, { parent = c.transient_for })
                awful.placement.no_offscreen(c)
            end
        end)
    end,
}
