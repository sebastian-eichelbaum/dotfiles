-------------------------------------------------------------------------------
-- A nice fuzzy file finder
--

return {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },

    lazy = true,
    event = "VeryLazy",

    init = function()
        vim.cmd([[

            " Move FZF down
            let g:fzf_layout = { 'down': '~40%' }

            " fzf.vim specific settings go in here
            let g:fzf_vim = {}

            " Preview window. 50 percent at the right but hide the preview if
            " Less than 70 cols are available
            let g:fzf_vim.preview_window = ['right,50%,<70(hidden)']

            " Mapping of ui elements to Highlights
            " - ref https://github.com/junegunn/fzf/blob/master/README-VIM.md
            let g:fzf_colors =
            \ {
              "\ 'fg':      ['fg', 'Normal'],
              "\ 'bg':      ['bg', 'Normal'],
              "\ 'hl':      ['fg', 'Search'],
              "\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
              \ 'bg+':     ['bg', 'Visual', 'Visual'],
              "\ 'hl+':     ['fg', 'Search'],
              "\ 'info':    ['fg', 'Search'],
              "\ 'border':  ['fg', 'CursorLine'],
              "\ 'prompt':  ['fg', 'Keyword'],
              "\ 'pointer': ['fg', 'Keyword'],
              "\ 'marker':  ['fg', 'Keyword'],
              "\ 'spinner': ['fg', 'Search'],
              "\ 'gutter':  ['bg', 'CursorLine'],
              "\ 'header':  ['bg', 'Error']
            \ }


        ]])

        local map = require("util.keymap")
        map.n("<leader>e", ":Files<CR>", { desc = "Edit file", icon = "󱇧" })
        map.n("<leader>/", ":RG<CR>", { desc = "Search in files", icon = "󰱼" })
        map.n("<leader>#", ":RG <C-R><C-W><CR>", { desc = "Search word in files", icon = "󰱼" })
    end,
}
