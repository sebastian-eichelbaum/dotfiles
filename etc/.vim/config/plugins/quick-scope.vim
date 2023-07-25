" Nur anzeigen wenn die Tasten gedrückt werden. Sonst permanent und wie alle
" CursorMove trigger macht das scrollen lahm
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Ziel r und R sollen das selbe sein?
let g:qs_ignorecase = 0

" Colorscheme
" Either use this:
"augroup qs_colors
"  autocmd!
"  autocmd ColorScheme * highlight link QuickScopePrimary Warning
"  autocmd ColorScheme * highlight link QuickScopeSecondary Error
"augroup END
" Current FetzDark supports this plugin already

let g:qs_hi_priority = 2
