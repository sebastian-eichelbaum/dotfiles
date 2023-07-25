""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grepper
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:grepper = {}
" Build Verzeichnis ignorieren
let g:grepper.ag = { 'grepprg': 'ag --vimgrep --ignore-dir=build*' }

" Suchen per prompt
nmap <leader>/ :Grepper -tool ag<cr>

" Wort unterm Cursor suchen
nmap <leader># :Grepper -tool ag -cword -noprompt<cr>

" Operator - gsW -> wort suchen
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

