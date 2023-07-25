" Do not change dir on file selection. vim-rooter is doing it already
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitListCommits()
    let commits = systemlist('git log --oneline 2>/dev/null | head -n10')
    return map(commits, '{"line": v:val}')
endfunction

let g:startify_lists = [
        "\ { 'type': 'files',                        'header': ['   MRU'] },
        \ { 'type': 'dir',                          'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',                     'header': ['   Sessions'] },
        \ { 'type': function('s:gitModified'),      'header': ['   Modified'] },
        \ { 'type': function('s:gitUntracked'),     'header': ['   Untracked'] },
        \ { 'type': function('s:gitListCommits'),   'header': ['   Commits'] },
        \ { 'type': 'commands',                     'header': ['   Commands'] },
        \ ]

" Mit figlet erzeugen:
let g:ascii_vim8 =[
 \ '   __     ___              ___  ',
 \ '   \ \   / (_)_ __ ___    ( _ ) ',
 \ '    \ \ / /| | `_ ` _ \   / _ \ ',
 \ '     \ V / | | | | | | | | (_) |',
 \ '      \_/  |_|_| |_| |_|  \___/ ',
 \ ''
 \]

let g:ascii_neo =[
 \ '    _   _         __     ___           ',
 \ '   | \ | | ___  __\ \   / (_)_ __ ___  ',
 \ '   |  \| |/ _ \/ _ \ \ / /| | `_ ` _ \ ',
 \ '   | |\  |  __/ (_) \ V / | | | | | | |',
 \ '   |_| \_|\___|\___/ \_/  |_|_| |_| |_|',
 \ '',
 \]

if has('nvim')
    let g:startify_custom_header = g:ascii_neo
else
    let g:startify_custom_header = g:ascii_vim8
endif


