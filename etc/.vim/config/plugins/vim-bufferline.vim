""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Bufferline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bufferline soll den Dateinamen nicht in die Kommandozeile schreiben
let g:bufferline_echo = 0

" Zeichen für Modifikation
let g:bufferline_modified = '+'

" Linker und rechter Begrenzer eines Buffers
" NOTE: wird von airline überschrieben
"let g:bufferline_active_buffer_left = '['
"let g:bufferline_active_buffer_right = ']'

" Nummer des Buffers anzeigen?
let g:bufferline_show_bufnr = 1

" Rotation der Buffer?
let g:bufferline_rotate = 2

" Darstellung - wird von Airline überschrieben
"let g:bufferline_inactive_highlight = 'StatusLineNC'
"let g:bufferline_active_highlight = 'StatusLine'

" Soll der "active" Highlight genutzt werden wenn nur 1 Buffer?
let g:bufferline_solo_highlight = 0

