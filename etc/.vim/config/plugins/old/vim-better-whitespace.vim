" Komplett abschalten?
let g:better_whitespace_enabled=1

" Whitespaces entfernen beim speichern
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_only_modified_lines=0

" Do not do it on these files:
" let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
" Nicht ändern per Verzeichnis.
" autocmd BufRead /usr/src/linux* DisableStripWhitespaceOnSave

" Spaces for tabs markieren
let g:show_spaces_that_precede_tabs=1

