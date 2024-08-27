
-- Handle init - use this to setup clients after init.
local function onInit()
    --
end

-- Setup the key bindings after an LSP client has been attached
local function onAttach()
    --
end

local function globalInit()
end

return {
    setup = function()
        -- Setup all LSP servers

        local lspconfig = require('lspconfig')

        local defaultConfig = {
            on_attach = onAttach,
            on_init = onInit,
        }

        -- C++:
        lspconfig.clangd.setup(defaultConfig)
        lspconfig.cmake.setup(defaultConfig)

        -- JS/TS
        lspconfig.tsserver.setup(defaultConfig)
    end
}
