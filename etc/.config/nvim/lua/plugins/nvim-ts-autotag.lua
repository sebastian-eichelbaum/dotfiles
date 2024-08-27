-------------------------------------------------------------------------------
-- Automatic /end tags for html/xml/...
--
-- (requires treesitter)

return {
    "windwp/nvim-ts-autotag",

    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    opts = {
        opts = {
            -- Defaults
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
        },

        -- Override settings:
        per_filetype = {
            --["html"] = { enable_close = false },
        }
    },
}
