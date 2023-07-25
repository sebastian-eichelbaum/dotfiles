""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local VIMRC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Dieser Name für die Datei:
let g:localvimrc_name=[ ".lvimrc", "lvimrc" ]
" Nicht nerven und nachfragen.
let g:localvimrc_ask=0
" Keine Sandbox nutzen
let g:localvimrc_sandbox=0

" localvimrc geht rückwärts bis root. Wieviele der gefundenen sollen genutzt
" werden? 1 bedeutet nur die erste gefundene. -1 sind alle.
" Achtung: ich habe dazu eine Blacklist definiert.
let g:localvimrc_count=-1

" Wie für you-complete-me auch, hier eine Liste der erlaubten Verzeichnisse,
" aus denen lvimrc geladen werden dürfen:
let g:localvimrc_whitelist=[ $HOME+'/Projekte/.*', $HOME+'/Dokumente/.*']

