-------------------------------------------------------------------------------
-- Nice git change icons and some
--

return {
    "mhinz/vim-signify",

    config = function ()
        vim.cmd([[
            let g:signify_sign_add               = '░'
            let g:signify_sign_delete            = '░'
            let g:signify_sign_delete_first_line = '░'
            let g:signify_sign_change            = '░'

            " Show number of deleted lines to signify_sign_delete
            let g:signify_sign_show_count = 0
        ]])
    end,
}
