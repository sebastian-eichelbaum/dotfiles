""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Erweitertes Verhalten durch kleine Skripte
"  - Einiges ist Dateityp-spezifisch.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Einstellungen für default plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Garnicht erst laden:
" let g:loaded_matchparen = 1

" Matchparen macht scrollen recht langsam. Man kan mit timeouts spielen aber
" das macht nur wenig Unterscheid.
" let g:matchparen_timeout = 2
" let g:matchparen_insert_timeout = 2

" Oder abschalten per
" NoMatchParen

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dateiformat- spezifische Einstellungen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Diese Zeile stellt sicher, dass tex Dateien immer als latex erkannt werden und
" nicht als plaintex
let g:tex_flavor='tex'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QuickFIX spezifische Einstellungen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Spell in QuickFix abschalten
au FileType qf setlocal nospell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Doxgen Syntax aktivieren
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Einige syntax plugins wie c, cpp, c# und java unterstützen das
let g:load_doxygen_syntax=1
let g:doxygen_enhanced_color=1

