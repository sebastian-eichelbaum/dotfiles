""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DirDiff plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Keine mappings
let g:DirDiffEnableMappings = 0

" Sprache von "diff" selbst ermitteln
let g:DirDiffDynamicDiffText = 1

" Sets default exclude pattern:
let g:DirDiffExcludes = 'CVS,*.exe,.*.swp,.git,.repo'

" Sets default ignore pattern:
let g:DirDiffIgnore = 'Id:,Revision:,Date:'

" If DirDiffSort is set to 1, sorts the diff lines.
let g:DirDiffSort = 1

" Sets the diff window (bottom window) height (rows)
let g:DirDiffWindowSize = 14

" Ignore case during diff
let g:DirDiffIgnoreCase = 0

" German version of diff
"let g:DirDiffDynamicDiffText = 0
"let g:DirDiffTextFiles = 'Dateien '
"let g:DirDiffTextAnd = ' und '
"let g:DirDiffTextDiffer = ' sind verschieden'
"let g:DirDiffTextOnlyIn = 'Nur in '

