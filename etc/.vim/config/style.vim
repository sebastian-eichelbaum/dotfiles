""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" GUI
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Farben und Aussehen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" True Color Terminal
if (has('termguicolors'))
  set termguicolors
else
  set t_Co=256
endif

" Farbgestaltung
colo FetzDark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Design und Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Zeilennummern anzeigen
set number

" Sign-Column immer anzeigen (yes) oder nur bei bedarf (auto)
" auto:Min-Max
" Beachte dass der auto-mode zwar mehrere signs nebeneinander erlaubt, aber es
" auch den text hin und her springen lässt wenn eine neue column notwendig
" wird.
"set signcolumn=auto:1-3
set signcolumn=yes

" Permanente Anzeige der Zeile/Spalte in der Statuszeile. Hinweis: unspannend
" wenn sowas wie Plugins wie "Powerline" oder "Airline" benutzt werden.
set ruler
" Relatiive Nummerierung im ruler.
set relativenumber

" Zeile des Cursor markieren
set cursorline

" Suchergebnisse markieren und hervorheben
set hlsearch

" Statuszeile immer anzeigen
set laststatus=2

" Modus in Statuszeile anzeigen?
" set showmode
" Nö. Powerline macht das
set noshowmode

" Partielle Kommandos anzeigen. Das bezieht sich auf Eingaben während versch.
" Modi
set showcmd

" Maus in allen modes auch auf der Konsole nutzen
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + GUI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Schrift (mit Powerline-Symbolen)
" set guifont=Liberation\ Mono\ for\ Powerline\ 9
" set guifont=Hack\ 9
set guifont=Hack\ Nerd\ Font\ 9
let s:uname = system("uname")
if s:uname == "Darwin\n"
    set guifont=LiterationMonoPowerline:h12
endif

" Titel setzen - geht auch im Konsolen-Vim
set titlestring=\[%n\]\ %<%t\ %m%r
set title

if !has('nvim')
    " Alle menüs, scrollbars usw loswerden
    set guioptions=

    " Konsolen-artige Menüs und Anzeigen für das meiste nutzen.
    set guioptions+=c

    " Automatisch Auswahl und Vismode mit X11 Primary buffer (selection
    " buffer) abgleichen?
    "set guioptions+=a
    " Das gleiche aber nur für modeless select (CTRL-SHIFT-Leftmouse)
    "set guioptions+=A

    " Darkmode nutzen
    set guioptions+=d

    if has('gui_running')
        " Zeilenabstand in +/- Pixel
        " set linespace=1

        " Menü-Taste deaktivieren
        set winaltkeys=no
    endif
endif

