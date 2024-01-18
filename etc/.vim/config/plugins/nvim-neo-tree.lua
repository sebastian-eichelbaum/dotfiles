vim.cmd([[nnoremap \ :Neotree toggle<cr>]])

require("neo-tree").setup({
    filesystem = {
        hijack_netrw_behavior = "open_current",
    }
})
