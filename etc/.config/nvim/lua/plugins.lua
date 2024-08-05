return {
    -- Automagically save/restore views
    "vim-scripts/restore_view.vim",

    {
        "neovim/nvim-lspconfig",

        config = function()
           -- require'lspconfig'.clangd.setup{}
        end
    }

}
