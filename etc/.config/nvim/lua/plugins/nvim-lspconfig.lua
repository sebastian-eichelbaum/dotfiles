return {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        -- All the LSP/CMP/Mason magic is in this one config
        require("config.lsp").setup()
    end,
}
