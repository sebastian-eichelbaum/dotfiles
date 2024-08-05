-------------------------------------------------------------------------------
--
-- Helper and tiny plugins
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Close the current buffer and quit VIM if the last buffer is closed.
vim.cmd([[
    function QuitIfLastBuffer()
        let cnt = 0
        for nr in range(1,bufnr("$"))
             if buflisted(nr) && ! empty(bufname(nr))
                 let cnt += 1
             endif
        endfor
        if &mod
            echohl ErrorMsg
            echo 'Unsaved Changes.'
            echohl NONE
            return
        endif

        if cnt == 1
            :q
        else
            :bd
        endif
    endfunction
]])


-------------------------------------------------------------------------------
-- Jump to the first non-whitespace character in a line, or to the beginning
-- of a line
vim.cmd([[
    function ExtendedHome()
        let column = col('.')
        normal! ^
        if column == col('.')
            normal! 0
        endif
    endfunction
]])


-------------------------------------------------------------------------------
-- Switch de/en/none spelllang
vim.cmd([[
    function! ToggleSpell()
        if &spell
            if &spelllang == "de"
                set spelllang=de,en
                echo "toggle spell" &spelllang
            elseif &spelllang == "de,en"
                set spelllang=en
                echo "toggle spell" &spelllang
            else
                set spell!
                echo "toggle spell off"
            endif
        else
            set spelllang=de
            set spell!
            echo "toogle spell" &spelllang
        endif
    endfunction
]])

-------------------------------------------------------------------------------
-- Strip white space at the end of lines when saving
-- Disable: let g:TrimWhiteSpaceDisabled = 1
vim.cmd([[
    func! TrimWhiteSpace()
        if exists("g:TriwWhiteSpaceDisabled")
            return
        endif
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
        exe "normal :delmarks z\n"
    endfunc

    autocmd BufWritePre <buffer> :call TrimWhiteSpace()
]])

-------------------------------------------------------------------------------
-- Avoid folding while in insert mode. This avoids nasty auto-folding when typing
vim.cmd([[
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
]])

-------------------------------------------------------------------------------
-- Automatically update Diff views when leaving insert mode
vim.cmd([[
    augroup AutoDiffUpdate
        au!
        autocmd InsertLeave * if &diff | diffupdate | let b:old_changedtick = b:changedtick | endif
        autocmd CursorHold *
            \ if &diff &&
            \    (!exists('b:old_changedtick') || b:old_changedtick != b:changedtick) |
            \   let b:old_changedtick = b:changedtick | diffupdate |
            \ endif
    augroup END
]])

-------------------------------------------------------------------------------
-- Highlight the yanked text
vim.cmd([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
]])
