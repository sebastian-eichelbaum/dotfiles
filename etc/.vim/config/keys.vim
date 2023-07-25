""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" KEYBINDINGS
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Die taste "leader" (<leader>) setzen. Default ist "/" aber das ist auf
" deutschen Keyboards nervig.
let mapleader=","

" Timeout für key combis
set timeoutlen=1000
" Timeout für terminal keycodes. Das nimmt vor allem Einfluss auf ESC.
set ttimeoutlen=10

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spelling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Spellingsprache umschalten
map <leader>s :call ToggleSpell()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlights modifizieren
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight Treffer per n und N - praktisch wenn durch viele Highlights
" gesprungen wird, man bekommt sofort visuelles Feedback auch wenn der Cursor
" weite Sprünge macht die man sonst visuell schwer verfolgen kann.
nnoremap <silent> n   n:call HLNext(0.25)<cr>
nnoremap <silent> N   N:call HLNext(0.25)<cr>

" Wie * und # aber ohne direkt zum nächsten Treffer zu springen.
nnoremap * *``
nnoremap # #``

" Treffer nicht mehr anzeigen
" ESC zu mappen bringt ein Problem: im Terminal aus dem Vis mode raus per ESC
" würde dann timeoutlen anstelle von ttimeoutlen nutzen -> nervig.
" noremap <silent> <ESC><ESC> :nohlsearch<CR>
noremap <silent> <leader><ESC> :nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pufferoperationen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffer wechseln (vorwärts: strg-tab, rückwärts: strg-shift-tab) - geht aber nicht in
" jedem Terminal :-( -> Daher die Alternative per leader
noremap  <silent> <leader><s-tab> <ESC>:bprevious!<CR>
noremap  <silent> <leader><tab> <ESC>:bnext!<CR>

" Schnell schreiben und schließen
" noremap <silent> <leader>wq :update<CR>:call QuitIfLastBuffer()<CR>
noremap <silent> <leader>w :update<CR>
noremap <silent> <leader>q :call QuitIfLastBuffer()<CR>
noremap <silent> <leader>Q :qa<CR>

" ganzen Buffer auswählen
" -> besser: ":%CMD" -> ganzen buffer kopieren: ":%y"
"noremap  <C-A> gggH<c-o>G
"inoremap <c-a> <c-o>gg<c-o>gH<c-o>G
"cnoremap <c-a> <c-c>gggH<c-o>G
"onoremap <c-a> <c-c>gggH<c-o>G
"snoremap <c-a> <c-c>gggH<c-o>G
"xnoremap <c-a> <c-c>ggV

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy, Paste und Cut
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" d im normal mode soll NICHT ins PRIMARY oder SECONDARY clipboard gehen.
nnoremap <Del> "0x

" einfügen im command mode
cnoremap <c-v>   <c-r>+

" Pastemode mit F2 umschalten. Praktisch beim Einfügen von Codeblöcken um zu verhindern
" dass VIM die neu formatiert.
"set pastetoggle=<F2>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatierung
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Verschieben eines Blocks, dabei bleibt die Auswahl (Visual oder Select)
" erhalten.
" -> besser: visual, dann < oder >, "." zum wiederholen
" vnoremap <s-tab> <gv
" vnoremap <tab> >gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Zeilenanfang/Ende Spezial
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <silent> <Home> :call ExtendedHome()<CR>
inoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>
vnoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sonst keine Plugin bindings. Die werden in den Plugin Configs gesetzt
