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

local M = {}

-- Called, once a LSP server is attached to a buffer. Use this to setup key bindings. The bufnr is given.
M.mappings = function(bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    map.group("<leader>c", "Code & LSP", "")

    map.buf.n(bufnr, "<leader>cf", function()
        vim.lsp.buf.code_action({
            apply = true,
        })
    end, { desc = "Code fix", icon = "󰁨" })

    map.buf.n(bufnr, "<leader>ff", function()
        vim.lsp.buf.code_action({
            apply = true,
        })
    end, { desc = "Fast code fix", icon = "󰁨" })

    map.buf.n(bufnr, "<leader>cD", vim.lsp.buf.declaration, { desc = "Go to declaration", icon = "" })
    map.buf.n(bufnr, "<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition", icon = "󰅲" })
    map.buf.n(bufnr, "<leader>ci", vim.lsp.buf.implementation, { desc = "Go to implementation", icon = "󰅩" })
    map.buf.n(bufnr, "<leader>ct", vim.lsp.buf.type_definition, { desc = "Go to type-definition", icon = "" })

    map.n("<leader>c<F2>", vim.lsp.buf.rename, { desc = "Rename symbol", icon = "" })
    map.buf.n(bufnr, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", icon = "󰁨" })

    map.buf.n(bufnr, "<leader>cI", vim.lsp.buf.hover, { desc = "Hover info", icon = "" })
    map.buf.n(bufnr, "<leader>cS", vim.lsp.buf.signature_help, { desc = "Signature help", icon = "󰊕" })

    map.buf.n(bufnr, "<leader>cS", vim.lsp.buf.signature_help, { desc = "Signature help", icon = "󰊕" })

    map.buf.n(bufnr, "<leader>ch", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Inlay Hint", icon = "󰷻" })

    -- NOTE: refer to the plugins config. There are probably plugins that provide nicer lists.
    -- map.buf.n(bufnr, "<leader>cr", vim.lsp.buf.references, { desc = "References", icon = "󰈇" })
    -- map.buf.n(bufnr, "<leader>ch", vim.lsp.buf.typehierarchy, { desc = "Type hierarchy", icon = "" })
end

-- A list of LSP servers to start and configure.
-- Maps the language server to a bunch of settings. They are server and language specific. Refer to lspconfig for
-- details.
M.servers = {
    clangd = {
        init_options = {
            fallbackFlags = { "--std=c++23" },
        },
        cmd = {
            "clangd",
            "--experimental-modules-support",
        },
    },
    cmake = {},
    ts_ls = {},
    bashls = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                        -- VIM
                        "vim",
                        "require",
                        -- AwesomeWM
                        "awesome",
                        "client",
                        "tag",
                        "screen",
                        "root",
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
}

-- The icons used for each symbol kind in completion menus
M.kindIcons = {
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
}

-- The icons that denote the source of the completion entry. (aka menu icon)
M.sourceIcons = {
    buffer = "",
    path = "",
    lsp = "󰅴",
    snippet = "",
    unknown = "?",
}

M.menuBorder = {
    " ",
    "▁",
    " ",
    "▏",
    " ",
    "▔",
    " ",
    "▕",
}

M.infoBorder = "rounded"

-- Additional Setup
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = M.infoBorder,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = M.infoBorder,
})

return M
