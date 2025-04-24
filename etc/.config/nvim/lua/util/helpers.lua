local M = {}

function M.bufCount()
    local bufnrs = vim.tbl_filter(function(b)
        if 1 ~= vim.fn.buflisted(b) then
            return false
        else
            return true
        end
    end, vim.api.nvim_list_bufs())

    return #bufnrs
end

-- Close the buffer, or if the buffer is the last one, close VIM.
--
-- There is a nasty bug in neo-tree. When closing a buffer via :bd while the tree is open,
-- VIM closes even if there are more buffers open. This function was taken from LazyVim ui utils but modified.
--
-- @param buf number?
function M.closeBuffer(buf)
    buf = buf or 0
    buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

    if vim.bo.modified then
        vim.cmd([[
            echohl ErrorMsg
            echo 'Unsaved Changes.'
            echohl NONE
        ]])
        return
    end

    if M.bufCount() == 1 then
        vim.cmd("q")
        return
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.api.nvim_win_call(win, function()
            if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
                return
            end
            -- Try using alternate buffer
            local alt = vim.fn.bufnr("#")
            if alt ~= buf and vim.fn.buflisted(alt) == 1 then
                vim.api.nvim_win_set_buf(win, alt)
                return
            end

            -- Try using previous buffer
            local has_previous = pcall(vim.cmd, "bprevious")
            if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
                return
            end

            -- Create new listed buffer
            local new_buf = vim.api.nvim_create_buf(true, false)
            vim.api.nvim_win_set_buf(win, new_buf)
        end)
    end
    if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.cmd, "bdelete! " .. buf)
    end
end

return M
