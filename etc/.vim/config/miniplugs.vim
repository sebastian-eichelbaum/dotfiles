""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ CamelCase Spelling abschalten.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Spelling für CameCaseWörter unterbinden.
fun! IgnoreCamelCaseSpell()
  " Match Abc, abcDe, and similar, preceded by _ or [a-z]_
  syn match CamelCase /\<[a-z]\=_\=[A-Z]\=[a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  " Vorsicht: betrifft auch Syntaxelemente mit Zahlen
  " syn match WordFollowedByNum /\<\w\+[0-9]\+\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
  "syn cluster Spell add=WordFollowedByNum
endfun
" Performance?
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Kein Folding im Insert-Mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Problem: Syntax als Methode ist extrem lahm. Besonders im Insert-Mode.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Textbreitenkonfiguration in einem Schlag
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Kleine Funktion um alles mit einem Schlag zu setzen. Aufruf per
" :call UpdateTextwidth(123)
func! UpdateTextwidth(width)
  let &l:textwidth=a:width
  let tooLargeColumn=a:width+1
  let &l:colorcolumn=tooLargeColumn
  " Match - warnung: das kann VIM extrem verlangsamen.
  " let twmatch='\%'.tooLargeColumn.'v.\+'
  " :call matchadd( 'OverLength', twmatch, -1 )
endfunc

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Automatisches diffudate beim Verlassen des Insert-Mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Diffs automatisch aktualisieren wenn man den Insert Mode verlässt
augroup AutoDiffUpdate
  au!
  autocmd InsertLeave * if &diff | diffupdate | let b:old_changedtick = b:changedtick | endif
  autocmd CursorHold *
        \ if &diff &&
        \    (!exists('b:old_changedtick') || b:old_changedtick != b:changedtick) |
        \   let b:old_changedtick = b:changedtick | diffupdate |
        \ endif
augroup END

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Trailing Spaces markieren und entfernen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Trailing Whitespace beim schreiben entfernen - Abschalten per
" let g:TriwWhiteSpaceDisabled = 1
" Darstellen über set list und listchars. Farbe durch SpecialKey definiert
func! TrimWhiteSpace()
  if exists("g:TriwWhiteSpaceDisabled")
    return
  endif
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
  exe "normal :delmarks z\n"
endfunc

" Für codes direkt aufrufen beim speichern
" autocmd FileType c,cpp,java,php,py,vo_base,python,bash,sh,glsl autocmd BufWritePre <buffer> :call TrimWhiteSpace()
autocmd BufWritePre <buffer> :call TrimWhiteSpace()

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Beim öffnen an die zuletzt genutzte Stelle springen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Immer an der zuletzt bearbeiteten Stelle öffnen
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Sprachen für Spelling umschalten
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Nutzen per map
function! ToggleSpell()
    if &spell
        if &spelllang == "de"
            set spelllang=de,en
            echo "toggle spell" &spelllang
        elseif &spelllang == "de,en"
            set spelllang=en
            echo "toggle spell" &spelllang
        else
            set spell!
            echo "toggle spell off"
        endif
    else
        set spelllang=de
        set spell!
        echo "toogle spell" &spelllang
    endif
endfunction

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Hightlight aktueller Treffer für # und * per n und N
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Suchen per N - > mit der unteren Funktion kurz aufblinken lassen. Das
" erleichtert bei sehr vielen Matches die visuelle Verfolgung des Cursors.
" ACHTUNG: jeder Match wird 500ms beleuchtet. Das sorgt für eine Gewisse
" Trägheit beim schnellen durchspringen der Matches.
function! HLNext (blinktime)
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#\%('.@/.'\)'
  let ring = matchadd('SearchCurrent', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Vim mit dem letzten Buffer schließen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ich möchte dass VIM zugeht wenn der letzte Buffer geschlossen wird. Um aber
" Probleme mit Plugins zu vermeiden, nehme ich kein Autocmd BufClose.
function QuitIfLastBuffer()
    let cnt = 0
    for nr in range(1,bufnr("$"))
         if buflisted(nr) && ! empty(bufname(nr))
             let cnt += 1
         endif
    endfor
    if &mod
        echohl ErrorMsg
        echo 'Unsaved Changes.'
        echohl NONE
        return
    endif

    if cnt == 1
        :q
    else
        :bd
    endif
endfunction

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Erweiterte HOME Taste
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Home springt wie ^ an den Anfang der Zeile an der der erste Buchstabe steht.
" aber wenn man bereits da bereits steht: Sprung zum Zeilenanfang.
function ExtendedHome()
    let column = col('.')
    normal! ^
    if column == col('.')
        normal! 0
    endif
endfunction

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Filetype aliases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au BufRead,BufNewFile *.shader set filetype=glsl
au BufRead,BufNewFile *.shaderh set filetype=glsl

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Convert Hex color code to X11 color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Converts the hex code under the cursor to the best matching X11 code and
" prints it on the echo line
function! ConvertHexToX11()

    let l:wordUnderCursor = expand("<cword>")

    py3 << EOF
import vim

N = []
for i, n in enumerate([47, 68, 40, 40, 40, 21]):
    N.extend([i]*n)

def rgb_to_xterm(r, g, b):
    mx = max(r, g, b)
    mn = min(r, g, b)

    if (mx-mn)*(mx+mn) <= 6250:
        c = 24 - (252 - ((r+g+b) // 3)) // 10
        if 0 <= c <= 23:
            return 232 + c

    return 16 + 36*N[r] + 6*N[g] + N[b]

# Convert the word under the cursor
hex = vim.eval("l:wordUnderCursor")
if hex[0] == '#' and len(hex) == 7:
    h = hex[1:]
    print(hex + " -> " + str(rgb_to_xterm(*(int(n, 16) for n in (h[:2], h[2:4], h[4:])))))
else:
    print("Not a hex color")

EOF
endfunction
" }}}

