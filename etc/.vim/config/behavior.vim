""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Grundlegendes Verhalten
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Immer wenn ein Komplettierungsvorschlag angezeigt wird soll das preview Fenster
" versteckt werden. Automatische Auswahl des längsten Treffers per "longest".
set completeopt="menu,menuone,longest,popup"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Grundlegend
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax highlighting einschalten
syntax on

" No-compatible Modus für VIM. Wichtig: wird für fast alle Plugins benötigt.
set nocompatible

" Buffer werden beim Wechsel nicht geschlossen, sondern versteckt. Das heißt:
"  -> Buffer wechseln ohne zu speichern!
set hidden

" Anzahl aller Änderungen immer anzeigen. Das ist ein Threshold.
set report=0

" Aktuelles Verzeichnis für die Auswahl einer Datei nutzen.
set browsedir=current

" Außen veränderte Dateien automatisch neu laden
set autoread

" Sprache der Rechtschreibprüfung wählen und aktivieren. Nicht standardmäßig
" aktiv. Nervt nur. Wird in den Projekten/Dokumentverzeichnissen durch lvimrc
" aktiviert. Sprache mit <leader>s durchschalten.
set spelllang=de,en
set nospell

" Modelines aktivieren. Actung: das local_vimrc plugin fuchtelt da rein und
" macht modelines unfunktional.
set modeline
set modelines=2

" Lange History der Kommandos.
set history=10000

" Unterstützte Dateitypen. Alles erlauben, da "Mac" unter Unix fehlt, man aber
" hier und da damit zu tun hat.
set fileformats=unix,dos,mac

" Kommandos mit kleinem Menü vervollständigen. Wie in der Konsole.
set wildmenu

" Ignoriere doe üblichen Verdächtigen in Projektverzeichnissen
set wildignore=*/.git/*,*/.hg/*,*/.svn/*,*/.repo/*

" Make rendering faster?!
set ttyfast
set lazyredraw

" Kein Piepsen und Blinken
set noerrorbells
set novisualbell

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" keine ":intro" message
set shortmess+=I

" keine Completion messages wie "match 1 of 2" usw.
set shortmess+=c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Encodings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ich bevorzuge grundsätzlich UTF-8. Damit kommen unter allen Systemen alle
" Editoren klar (aus Window's Notepad ;-)).
set fileencoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Umbruch und Wrap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatisches Umbrechen OHNE Einfügung eines Zeilenumbruch.
set textwidth=0
set wrapmargin=0
set wrap

" Gewrappten text dezent einrücken und markiern
set breakindent
set showbreak=···
"set showbreak=•••
"set showbreak=┗━╸

" Aber ein Hinweis ist nett!? Standardmäßig die üblichen 80, 120, 150
" set colorcolumn=81,121,151
" set colorcolumn=151

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Tabulator
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ein tab soll N Leerzeichen breit sein.
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Tabs durch Leerzeichen ersetzen
set expandtab
set smarttab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Unsichtbare Zeichen anzeigen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Zeige spezielle Whitespace Sachen. Also Tabs, EOL, usw. per Zeichen.
" Konfigurierbar über "listchars".
set nolist

" Listchars wie default, aber mit entfernter Anzeige der Umbrüche. Außerdem
" ist Tab durch ein Unicode Zeichen ersetzt. Sieht cooler aus.
" ACHTUNG: Unicode Zeichen werden nur per exec "set ..." interpretiert?!
set listchars=tab:➜\ ,nbsp:¬,precedes:«,extends:»
"set listchars=tab:→\ ,nbsp:¬,precedes:«,extends:»,trail:•

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Einrückung und autoformat
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatisches einrücken.
set autoindent
" Schlauer Modus -> Toll in Code um automatisch ins passende Indent-Level zu
" springen.
set smartindent

" Optimierte Einrückung für C/C++ codes aktivieren.
set cindent

" Kommentare und Listen automatisch fortsetzen.
" :help 'fo-table' zeigt die Optionen
set formatoptions+=tron

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Suche
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Inkrementelle Suche aktivieren
set incsearch

" Groß und Kleinschreibung ignorieren
set ignorecase

" Wird dennoch ein Großbuchstabe benutzt wird case-sensitiv gesucht
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Nur per Markierung. Wichtig: Syntax als Methode ist sehr langsam. Sollte man
" vermeiden.

set foldmethod=marker
" set foldmethod=manual

" Breite der Spalte zum Anzeigen der Faltung. 1 ist zu eng. 3+ zeigt unnötige
" Details.
set foldcolumn=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Bewegung
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bewegung auch per Cursor, Backspace über das Zeilenende/Anfang hinweg.
"  - <,> ist Cursor in Normal/Vis
"  - [,] ist Cursor im insert mode
"  - ~ ist reverse case
set whichwrap+=b,s,<,>,[,]

" Backspace soll über Zeilenende/Anfang und Indent arbeiten können.
set backspace=eol,start,indent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Textauswahl und Clipboards
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set clipboard=

" In console nicht clipboarden. Im Terminalemulator aber schon
" set clipboard=exclude:cons\|linux

" Automativ per Maus oder Visual Mode ausgewählten Bereich mit X Primary
" abgleichen. Warnung: das müllt den Buffer voll, da es für jede Bewegung im
" Visual Mode einen Eintrag in der Clipboardhistorie erzeugt.
" In den keys gibt es einen einfachen Select per Maus Trick der Mausauswahl
" abgleicht, aber Visual/Select Mode nicht.
"set clipboard+=autoselect

" Zwischenablagemodus - es soll ins unnamedplus Register gehen. Dieses ist mit
" dem X-Server Secondary (clip) buffer gekoppelt. Also der CTRL-C/V buffer.
" Das setzt "+ als register für change,delete,paste,yank
set clipboard+=unnamedplus

" Selection-Mode aktivieren per Maus und per Shift-Cursor. Die Option "cmd" würde
" v,V,Ctrl-V ersetzen.
" Der select Mode unterscheidet sich vom visual mode dahingehend, dass jeder
" weiterer Tastendruck die Auswahl ersetzt. Also: wählen per shift cursor,
" tippen um direkt zu ersten.
"set selectmode=key,mouse
"set selectmode=mouse

" Damit man mit Shift+Cursor/PageUp/PageDown/Home/End den Selection-Mode
" starten kann:
"set keymodel=startsel,stopsel
set keymodel=startsel

" Maus per Klick der rechten Taste löst Menü aus. Position des Cursor wird an
" Position der Maus geschoben
set mousemodel=popup_setpos

" Modus der Auswahl. Inclusive oder Exclusive. Der Unterschied ist, ob im
" Normal-Mode das letzte Zeichen in die Operation eingeschlossen wird
" (inclusive)
"set selection=exclusive

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Views automatisch erzeugen - speichern von folds usw.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set viewoptions=cursor,folds,slash,unix
