" Colorscheme
hi link CtrlPMatch IncSearch
hi link CtrlPNoEntries Error

" Datei öffnen, Buffer durchsuchen ...
let g:ctrlp_map='<leader>o'
let g:ctrlp_cmd='CtrlP'

" File-mode. Nur Dateinamen matchen? Wenn 0, dann auch Pfade. Mit <c-d>
" umschaltbar
let g:ctrlp_by_filename = 1

" Regex Modus? Mit <c-r> umschaltbar
let g:ctrlp_regexp = 0

" Was ist das zu durchsuchende 'root'
let g:ctrlp_working_path_mode='wra'

" Cache löschen wenn beendet?
let g:ctrlp_clear_cache_on_exit = 0


" 'c' - the directory of the current file.
" 'a' - the directory of the current file, unless it is a subdirectory of the cwd
" 'r' - the nearest ancestor of the current file that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'w' - modifier to "r": start search from the cwd instead of the current file's directory
" 0 or '' (empty string) - disable this feature.

" Die Erkennung von "Root" kann erweitert werden
let g:ctrlp_root_markers=['lvimrc', '.lvimrc']

" Auch versteckte Dateien
let g:ctrlp_show_hidden=1

" Maximale Rekursion
let g:ctrlp_max_depth = 50

" Kein file-limit. Bei großen Projekten lohnenswert.
let g:ctrlp_max_files = 0

" Immer im Verzeichnis der aktuellen Datei als Vorauswahl starten?
let g:ctrlp_default_input=0

" Symlinks folgen? Versucht loops zu vermeiden.
let g:ctrlp_follow_symlinks = 1

" Ignorieren nach pattern
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](build|build-.*|build_.*|doc|\.repo)$',
  \ 'file': '\v\.(exe|so|dll|png|jpg|jpeg|pyc|swp)$',
  \ }


