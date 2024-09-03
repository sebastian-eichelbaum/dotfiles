local map = require("util.keymap")

-- Configure the diagnostics feature of NeoVim. It is used once a LSP is attached. Some other plugins might also use it.

-- Diagnostics setup:
vim.diagnostic.config({
    -- The text right to the code with issues.
    virtual_text = {
        prefix = "┃", -- Could be '●', '▉', '┃', '▎', 'x', '❯❯'
    },
    -- Gutter signs?
    signs = true,
    -- Underline the affected part of the line?
    underline = true,
    -- If true, diagnostics are shown and updated in insert mode
    update_in_insert = true,
    -- Sort by severity. If false, a warning might be shown although there is an error on the same line.
    severity_sort = true,

    -- Diagnostics as floats.
    float = {
        border = "rounded",
        source = "always", -- Or "if_many"
    },
})

-- Gutter signs:
-- local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
local signs = { Error = "┃ ", Warn = "┃ ", Hint = "┃ ", Info = "┃ " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Key mappings

-- Jump through the diagnostics. Also shows the diag-list as float
map.n("[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", icon = "󰀪" })
map.n("]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", icon = "󰀪" })

-- map.n("<leader>cd", function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end, { desc = "Diagnostic details", icon = "" })
-- map.n("<leader>cD", vim.diagnostic.setloclist, { desc = "Diagnostic quickfix", icon = "" })
