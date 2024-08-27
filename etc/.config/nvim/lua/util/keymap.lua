local tableUtils = require("util.table")

local M = {}

-- Generate a key mapping in a given mode.
-- opts is a table that overrides the defaults.
M.map = function(mode, key, command, opts)

    -- Merge the user options with the defaults
    local mergedOpts = tableUtils.merge(
        -- Default values
        { noremap = false, silent = true, }, opts)
    local icon = mergedOpts.icon

    -- Not supported by vim.keymap.set
    mergedOpts.icon=nil

    -- Set it up
    vim.keymap.set(mode, key, command, mergedOpts)

    -- If which key is present, provide icon, group, ....
    local hasWhichKey, whichkey = pcall(require,"which-key")
    if hasWhichKey then
        whichkey.add({
            key,
            mode = mode,
            icon = icon,


        })
    else
    end
end

-- Generate a Normal-mode mapping.
M.n = function(key, command, opts)
    M.map("n", key, command, opts)
end

-- Generate a Visual-mode mapping.
M.v = function(key, command, opts)
    M.map("v", key, command, opts)
end

-- Generate an Insert-mode mapping.
M.i = function(key, command, opts)
    M.map("i", key, command, opts)
end

-- Generate an Command-mode mapping.
M.c = function(key, command, opts)
    M.map("c", key, command, opts)
end

return M
