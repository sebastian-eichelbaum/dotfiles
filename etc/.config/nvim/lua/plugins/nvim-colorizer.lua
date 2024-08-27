-------------------------------------------------------------------------------
-- Show nice colors for hex codes and the like
--
-- :ColorizerToggle to enable

return {
    "norcalli/nvim-colorizer.lua",

    lazy = true,
    event = "VeryLazy",

    init = function()
        require 'colorizer'.setup({
            css = {
                css = true,
            },
            javascript = {},
            vim = {},
            html = {
                mode = 'foreground',
            },
        },
        -- Defaults:
        {
            RGB      = true;         -- #RGB hex codes
            RRGGBB   = true;         -- #RRGGBB hex codes
            names    = true;         -- "Name" codes like Blue
            RRGGBBAA = true;         -- #RRGGBBAA hex codes
            rgb_fn   = false;        -- CSS rgb() and rgba() functions
            hsl_fn   = false;        -- CSS hsl() and hsla() functions
            css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes: foreground, background
            mode     = 'background'; -- Set the display mode.
        })
    end,
}
