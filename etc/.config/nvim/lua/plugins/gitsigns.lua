-------------------------------------------------------------------------------
-- Nice git change icons and some
--

local function makeSigns()
    -- ┆ ┋ ┇ ╎ ╏  ░  ▒  ▓ ▍ │ ▏
    local icon = "┆"
    return {
        add          = { text = icon },
        change       = { text = icon },
        delete       = { text = icon },
        topdelete    = { text = icon },
        changedelete = { text = icon },
        untracked    = { text = icon },
    }
end

local gitsigns = {
    "lewis6991/gitsigns.nvim",

    lazy = true,
    event = { 'VeryLazy' },

    opts ={
        signs = makeSigns(),
        signs_staged = makeSigns(),

        -- Different signs for staged changes?
        signs_staged_enable = true,

        -- Indicate untracked files? Gets very noisy!
        attach_to_untracked = false,

        -- Show blame info next to the line?
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`

        -- When attaching, add some key mappings
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk)
            map('n', '<leader>hr', gitsigns.reset_hunk)
            map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('n', '<leader>hS', gitsigns.stage_buffer)
            map('n', '<leader>hu', gitsigns.undo_stage_hunk)
            map('n', '<leader>hR', gitsigns.reset_buffer)
            map('n', '<leader>hp', gitsigns.preview_hunk)
            map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
            map('n', '<leader>hd', gitsigns.diffthis)
            map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
            map('n', '<leader>td', gitsigns.toggle_deleted)
        end
    }
}

return gitsigns
