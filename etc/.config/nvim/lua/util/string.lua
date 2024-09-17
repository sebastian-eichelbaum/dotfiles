local M = {}

-- Crop a string to a given length and add an ellipsis if not nil. Ellipsis length is included in the given length
M.crop = function(str, length, ellipsis)
    if vim.fn.strchars(str) > length then
        local ell = ellipsis ~= nil and ellipsis or ""
        local ellipsisLength = vim.fn.strchars(ell)

        return vim.fn.strcharpart(str, 0, length - ellipsisLength) .. ell
    end
    return str
end

-- Ensure a given length for a string. If the extender string has a length != 1, the target length might be overshot.
M.extend = function(str, length, extender)
    if extender == nil then
        extender = "."
    end

    local currentLength = vim.fn.strchars(str)
    if currentLength < length then
        return str .. string.rep(extender, math.ceil((length - currentLength) / vim.fn.strchars(extender)))
    end

    return str
end

-- Crop and extend a string to ensure a length in the given range.
M.ensureLengthInRange = function(str, minLength, maxLength, ellipsis, extender)
    return M.extend(M.crop(str, maxLength, ellipsis), minLength, extender)
end

return M
