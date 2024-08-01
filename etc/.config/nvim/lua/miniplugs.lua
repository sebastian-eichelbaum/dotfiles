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
-- Short highlight of n/N matches when jumping through
vim.cmd([[
    function! HLNext (blinktime)
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#\%('.@/.'\)'
        let ring = matchadd('SearchCurrent', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
        call matchdelete(ring)
        redraw
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
-- Jump to the last cursor position when opening a file
vim.cmd([[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
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
-- Some text width magic.
-- TODO: still needed?
vim.cmd([[
    func! UpdateTextwidth(width)
        let &l:textwidth=a:width
        let tooLargeColumn=a:width+1
        let &l:colorcolumn=tooLargeColumn
    endfunc

    au BufReadPost * :call UpdateTextwidth(120)
]])

-------------------------------------------------------------------------------
-- Highlight the yanked text
vim.cmd([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
]])
