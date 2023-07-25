" Wenn kein Projektroot gefunden: gehe ins Verzeichnis der Datei. Ist für
" fuzzy finder und Grepper/Ag am besten sonst sucht man sein halbes
" Dateisystem durch
let g:rooter_change_directory_for_non_project_files = 'current'

" Win/Buffer local cd?
" let g:rooter_use_lcd = 1

" Keine Ausgabe über cwd
let g:rooter_silent_chdir = 0

" Symlink resolve? Was genau bewirkt das? Auch bei = 0 werden links
" aufgelöst?!
let g:rooter_resolve_links = 1

" Abschlaten
" let g:rooter_manual_only = 1

" Reihenfolge ist wichtig.
" in /home/Projekte/ gibt es eine lvimrc. Aber das .git dir im Projektnamexyz
" Verzeichnis soll vorrang haben.
let g:rooter_patterns = ['.repo/', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'lvimrc', '.lvimrc']
