""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme='FetzDark'
let g:airline_powerline_fonts = 1

" Diese Pfeile überscreiben:
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''

" Paste-Mode anzeigen?
let g:airline_detect_paste = 0

" Spell anzeigen?
let g:airline_detect_spell = 0

" Links zusammenfalten wenn fenster nicht aktiv?
let g:airline_inactive_collapse = 1

" Leere elemente verstecken
" Warnung: das versteckt die GIT sektion (branch, hunks)
" let g:airline_skip_empty_sections = 1

" preview ausschließen
let g:airline_exclude_preview = 0

" Kurze Modes
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

" Layout
"let g:airline#extensions#default#layout = [
"  \ [  'error', 'warning', 'a', 'b', 'c' ],
"  \ [ 'x', 'y', 'z' ]
"  \ ]

" Symbole -  Check :help airline-customization
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_symbols.dirty=' ≠'
let g:airline_symbols.dirty=' ~'
"let g:airline_symbols.branch = 'B:'
let g:airline_symbols.notexists = ' ٭'


" Bufferline Einstellungen nicht überschreiben?
" let g:airline#extensions#bufferline#overwrite_variables  = 0
" highlight bufferline_selected gui=bold guifg='red' cterm=bold term=bold

" Bug mit error/warning ... ?
let airline#extensions#default#section_use_groupitems = 0

" Keine venv erkennung
let g:airline#extensions#virtualenv#enabled = 0

" Keine Wortzählung
let g:airline#extensions#wordcount#enabled = 0

" Keine Whitespace meldungen
let g:airline#extensions#whitespace#enabled = 0

" enable/disable YCM integration
let g:airline#extensions#ycm#enabled = 0

" set error count prefix
"let g:airline#extensions#ycm#error_symbol = 'E:'
"let airline#extensions#coc#error_symbol = '▉ '

" set warning count prefix
"let g:airline#extensions#ycm#warning_symbol = 'W:'
"let airline#extensions#coc#warning_symbol = '▉ '

" Git details
" Beachte dass airline_skip_empty_sections 0 sein muss.
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

" Tabline?
let g:airline#extensions#tabline#enabled = 0

