-------------------------------------------------------------------------------
-- Provides an airline-like statusbar
--

local function getColor(group, attr)
    local matched = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
    if matched == nil then
        return "#ff0000"
    end
    return matched
end

local themeAdapter =
{
    normal = {
        a = { fg = "#ffffff", bg = getColor("FetzDarkPrimary", "bg#"), gui = "bold" },
        b = { fg = getColor("StatusLine", "fg#"), bg = getColor("StatusLine", "bg#") },
        c = { fg = getColor("StatusLineNC", "fg#"), bg = getColor("StatusLineNC", "bg#") },
    },

    insert = {
        a = { fg = getColor("Visual", "fg#"), bg = getColor("Visual", "bg#"), gui = "bold" },
    },

    replace = {
        a = { fg = getColor("Visual", "fg#"), bg = getColor("Visual", "bg#"), gui = "bold" },
    },

    visual = {
        a = { fg = getColor("Visual", "fg#"), bg = getColor("Visual", "bg#"), gui = "bold" },
    },

    command = {
        a = { fg = getColor("Normal", "bg#"), bg = getColor("Search", "fg#"), gui = "bold" },
    },

    inactive = {
        a = { fg = getColor("StatusLineNC", "fg#"), bg = getColor("StatusLineNC", "bg#") },
        b = { fg = getColor("StatusLineNC", "fg#"), bg = getColor("StatusLineNC", "bg#") },
        c = { fg = getColor("StatusLineNC", "fg#"), bg = getColor("StatusLineNC", "bg#") },
    },
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    opts = {
        options = {
            icons_enabled = true,
            theme = themeAdapter,

            component_separators = { left = '', right = ''},
            --section_separators = { left = '', right = ''},
            --section_separators = { left = '🭛', right = '🭋'},
        },

        sections = {
            -- Status as single letter
            lualine_a = {
                {
                    'mode',
                    fmt = function(str) return str:sub(1,1) end,
                }
            },

            -- Git status info
            lualine_b = {
                {
                    'branch',
                    icon = {'', align='left'},
                },
                {
                    'diff',
                    -- Re-format de detailed output to only show a small "modified" marker instead of
                    -- add/remove/change counts
                    fmt = function(str, context)
                        if str == nil or str == '' then
                            return ""
                        end
                        return ""
                    end,

                    padding = { left = 0, right = 1 },

                    -- color = { fg = '#a2bf6d', gui='bold' },
                },
            },

            -- The bufferlist
            lualine_c = {
                {
                    -- Add some space
                    function ()
                        return [[ ]]
                    end,
                    padding = 0
                },
                {
                    'buffers',

                    -- Split buffers NOT using the powerline arrows
                    section_separators = { left = '🭛', right = ''},

                    -- Use nvim-web-devicons for file icons?
                    icons_enabled = false,

                    -- filenames or a shortened path relative to the CWD
                    show_filename_only = true,

                    mode = 2,   -- 0: Shows buffer name
                                -- 1: Shows buffer index
                                -- 2: Shows buffer name + buffer index
                                -- 3: Shows buffer number
                                -- 4: Shows buffer name + buffer number

                    buffers_color = {
                        active = { fg = '#dddddd', bg = 'background', gui='bold' },
                    },

                    symbols = {
                        modified = ' ',
                        alternate_file = '',
                        directory = '',
                    },
                },
            },

            lualine_x = {
                {
                    'filetype',
                    colored = false,   -- Displays filetype icon in color if set to true
                    icon_only = false, -- Display only an icon for filetype
                    icon = { align = 'left' }, -- Display filetype icon on the right hand side
                },
            },

            lualine_y = {
                {
                    function()
                        return [[]]
                    end
                },
                {
                    'encoding',
                    -- Show '[BOM]' when the file has a byte-order mark
                    show_bomb = false,

                    padding = { left = 1, right = 0 },
                },
                {
                    'fileformat',
                    symbols = {
                        unix = '[unix]',
                        dos = '[win]',
                        mac = '[mac]',
                    },

                    padding = { left = 0, right = 1 },
                },
            },

            lualine_z = {
                {
                    function()
                        return [[]]
                    end,
                    padding = { left = 1, right = 0 },
                },

                {
                    -- 'location' and 'progress' but with a bit nicer
                    function()

                        local line = vim.fn.line('.')
                        local col = vim.fn.charcol('.')
                        local total = vim.fn.line('$')

                        -- Handle some special cases
                        local perc = math.floor(line / total * 100)
                        if line == 1 then
                            perc = 0
                        elseif line == total then
                            perc = "100"
                        end

                        return string.format('%2d%%%% %2d/%d:%-3d', perc, line, total, col)
                    end,

                    padding = { left = 1, right = 1 },
                },
            },
        },
    }
}

