local M = {}

-- Merge two tables recursively. Does not copy and modifies t1 instead.
M.merge = function(t1, t2)
    local t1_ = t1 or {}
    local t2_ = t2 or {}
    for k, v in pairs(t2_) do
        if (type(v) == "table") and (type(t1_[k] or false) == "table") then
            M.merge(t1_[k], t2_[k])
        else
            t1_[k] = v
        end
    end
    return t1_
end

-- Recursively flatten a table into a target table
function flatten_(tbl, into)
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            flatten_(v, into)
        else
            into[k] = v
        end
    end
end

-- Recursively flatten a given table and return the flattened table.
M.flatten = function(t)
    local t_ = {}
    flatten_(t, t_)
    return t_
end

return M
