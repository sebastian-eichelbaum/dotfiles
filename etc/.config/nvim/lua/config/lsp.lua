local map = require("util.keymap")

return {
    -- Setup the LSPs using lsp-config.nvim
    setupLSP = function(lspconfig)
        -- C++:
        lspconfig.clangd.setup({})
        lspconfig.cmake.setup({})

        -- The JS/TS/... Webdev world
        lspconfig.tsserver.setup({})
    end,

    -- Setup the code formatters using: conform.nvim
    setupConform = function(conform)
        map.n("<leader>f", conform.format, { desc = "Format buffer", icon = "󰉼" })

        return {
            -- Tell conform which formatters to use
            formatters_by_ft = {
                -- C++ and related
                cpp = { "clang-format" },
                c = { "clang-format" },
                cmake = { "cmake_format" },

                -- The JS/TS/... Webdev world
                javascript = { "prettier" },
                typesript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                vue = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                toml = { "prettier" },

                -- For neovim and awesome ;-)
                lua = { "stylua" },

                -- Shell scripting, system stuff, ...
                sh = { "beautysh" },
                bash = { "beautysh" },
                nix = { "nixfmt" },

                -- Text
                markdown = { "prettier" },
            },

            -- Configure some formatters explicitly
            formatters = {
                beautysh = {
                    prepend_args = { "--indent-size", "4", "--force-function-style", "fnpar" },
                },
                stylua = {
                    -- Ensure sane defaults and make stylua search stylua.toml files recursively up
                    -- NOTE: --search-parent-directories is given by conform already
                    prepend_args = { "--indent-type", "Spaces" },
                },
            },
        }
    end,

    -- Setup Mason. This tool ensures the required LSP/formatters/linters/... are installed automatically
    setupMason = function(mason) end,
}
