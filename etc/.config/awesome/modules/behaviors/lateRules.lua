---------------------------------------------------------------------------------------------------
--
-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀
--
-- Re-apply rules once a client changes its class. This fixes issues with Spotify and others
-- that start with an empty window class.
---------------------------------------------------------------------------------------------------

local awful = require("awful")

-- TODO: check if still needed?

return {
    setup = function()

        -- Clients without an winbdow class: wait for a class asignment and re-apply rules.
        client.connect_signal( "manage", function ( c )
            if c.class == nil then
                c:connect_signal( "property::class", function ()
                    awful.rules.apply(c)
                end)
            end
        end)
    end
}

