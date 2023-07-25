---------------------------------------------------------------------------------------------------
--
-- ░█▀▄░█░█░█░░░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
-- ░█▀▄░█░█░█░░░█▀▀░░░█░░░█░█░█░█░█▀▀░░█░░█░█
-- ░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀
--
-- Awesome rule configuration.
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local ruled = require("ruled")

local lib = require("lib")
local config = require("config")

-- {{{ Library: Prepare and format rules

-- Get the tag associated with the ID given
function getTag(id)
    if id == nil then
        return nil
    end

    local tags = root.tags()
    for i = 1, #tags do
        if lib.array.contains(tags[i].ids, id) then
            return tags[i]
        end
    end

    return nil
end

-- Unroll the by-tag rule set into a flat set of rules. This evaluates the tagId and tries to find the right tag.
function flatten(rulesByTag)
    local flatRules = {}
    for i = 1, #rulesByTag do
        local rules = rulesByTag[i].rules
        local tag = getTag(rulesByTag[i].tagId)

        for ruleI = 1, #rules do
            local rule = rules[ruleI]
            rule.properties.tag = tag
            flatRules[#flatRules + 1] = rule
        end
    end
    return flatRules
end
-- }}}

return {
    setup = function()
        -- Rules to apply to new clients.
        ruled.client.connect_signal("request::rules", function()
            -- All clients will match this rule.
            ruled.client.append_rule {
                id         = "global",
                rule       = { },
                properties = config.clients.properties,
            }

            ruled.client.append_rules(flatten(config.rules))
        end)
    end
}
