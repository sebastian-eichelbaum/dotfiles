local tableUtils = require("util.table")

local M = {}

-- Generate a key mapping in a given mode.
-- opts is a table that overrides the defaults.
M.map = function(mode, key, command, opts)
    -- Merge the user options with the defaults
    local mergedOpts = tableUtils.merge(
        -- Default values
        { noremap = false, silent = true },
        opts
    )
    local icon = mergedOpts.icon
    local buffer = mergedOpts.buffer

    -- Not supported by vim.keymap.set
    mergedOpts.icon = nil

    -- Set it up
    vim.keymap.set(mode, key, command, mergedOpts)

    -- If which key is present, provide icon, group, ....
    local hasWhichKey, whichkey = pcall(require, "which-key")
    if hasWhichKey then
        whichkey.add({
            key,
            mode = mode,
            icon = icon,
            buffer = buffer,
        })
    end
end

M.group = function(key, name, icon)
    local hasWhichKey, whichkey = pcall(require, "which-key")
    if hasWhichKey then
        whichkey.add({
            key,
            group = name,
            icon = icon,
        })
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

M.buf = {
    -- Generate a Normal-mode mapping.
    n = function(buffer, key, command, opts)
        opts.buffer = buffer
        M.map("n", key, command, opts)
    end,

    -- Generate a Visual-mode mapping.
    v = function(buffer, key, command, opts)
        opts.buffer = buffer
        M.map("v", key, command, opts)
    end,

    -- Generate an Insert-mode mapping.
    i = function(buffer, key, command, opts)
        opts.buffer = buffer
        M.map("i", key, command, opts)
    end,

    -- Generate an Command-mode mapping.
    c = function(buffer, key, command, opts)
        opts.buffer = buffer
        M.map("c", key, command, opts)
    end,
}

return M
