return {
    'notjedi/nvim-rooter.lua',

    opts = {
        -- With git submodules, .git exists as file in a submodule. To
        -- make the top-level project the project root, use ".git/"
        -- with slash to match only git dirs.
        rooter_patterns = { '.repo/', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/' },

        -- If no root is found, go to the files own dir
        fallback_to_parent = true,
    }
}
