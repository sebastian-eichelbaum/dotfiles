-- Configure the user-facing parts of the LSP in Neovim.
-- LSP servers/clients are configured by a plugin like lspconfig.
-- LSP Completion menus are provided by plugins like nvim-cmp.
--
-- This only provides some style and key binding setup that will be used by those plugins once an LSP is attached to a
-- buffer.

local map = require("util.keymap")

local border = {
    " ",
    "▁",
    " ",
    "▏",
    " ",
    "▔",
    " ",
    "▕",
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border,
})

return {

    -- A list of LSP servers to start and configure.
    servers = { "clangd", "cmake", "ts_ls", "bashls", "lua_ls" },

    -- Called, once a LSP server is attached to a buffer. Use this to setup key bindings. The bufnr is given.
    mappings = function(bufnr)
        -- See `:help vim.lsp.*` for documentation on any of the below functions

        map.group("<leader>c", "Code & LSP", "")

        map.buf.n(bufnr, "<leader>cf", function()
            vim.lsp.buf.code_action({
                apply = true,
            })
        end, { desc = "Code fix", icon = "󰁨" })

        map.buf.n(bufnr, "<leader>cr", vim.lsp.buf.references, { desc = "References", icon = "󰈇" })
        map.buf.n(bufnr, "<leader>cD", vim.lsp.buf.declaration, { desc = "Go to declaration", icon = "" })
        map.buf.n(bufnr, "<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition", icon = "󰅲" })
        map.buf.n(bufnr, "<leader>ci", vim.lsp.buf.implementation, { desc = "Go to implementation", icon = "󰅩" })
        map.buf.n(bufnr, "<leader>ct", vim.lsp.buf.type_definition, { desc = "Go to type-definition", icon = "" })
        map.buf.n(bufnr, "<leader>ch", vim.lsp.buf.typehierarchy, { desc = "Show type hierarchy", icon = "" })

        map.buf.n(bufnr, "<leader>ck", vim.lsp.buf.hover, { desc = "Show hover info", icon = "" })
        map.buf.n(bufnr, "<leader>cs", vim.lsp.buf.signature_help, { desc = "Signature help", icon = "󰊕" })

        map.n("<leader>c<F2>", vim.lsp.buf.rename, { desc = "Rename symbol", icon = "" })
        map.buf.n(bufnr, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", icon = "󰁨" })
    end,

    -- The icons used for each symbol kind in completion menus
    kindIcons = {
        -- Callable things
        Function = "󰅲",
        Method = "󰅩",
        Constructor = "",

        -- Classes and Types
        Interface = "",
        Class = "",
        Struct = "󰙅",
        Enum = "",
        -- NOTE: this is a namespace in C++
        Module = "",

        -- Value-things
        Value = "󰎠",
        Text = "󰉿",
        EnumMember = "",
        TypeParameter = "",

        -- Variable things (named symbols)
        Variable = "󰫧",
        Field = "",
        Property = "",
        Constant = "󰏿",
        Event = "",

        -- Keywords and statements
        Operator = "󰆕",
        Keyword = "",

        Reference = "󰈇",
        File = "",
        Folder = "",
        Color = "",
        Unit = "",

        Snippet = "",

        -- Required by the plugin config for undefined/new/unknown symbols
        Default = "",
    },

    -- The icons that denote the source of the completion entry. (aka menu icon)
    sourceIcons = {
        buffer = "",
        path = "",
        lsp = "󰅴",
        snippet = "",
        unknown = "?",
    },
}
