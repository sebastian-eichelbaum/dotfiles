return {
    -- Crop a string to a given length and add an ellipsis if not nil. Ellipsis length is included in the given length
    crop = function(str, length, ellipsis)

        if vim.fn.strchars(str) > length then
            local ell = ellipsis ~= nil and ellipsis or ""
            local ellipsisLength = vim.fn.strchars(ell)

            return vim.fn.strcharpart(str, 0, length - ellipsisLength) .. ell
        end
        return str
    end,
}
