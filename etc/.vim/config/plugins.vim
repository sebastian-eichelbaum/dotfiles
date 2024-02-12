""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" PLUGIN - vim-plug
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug kümmert sich um sich selbst.
" - Update mit PlugUpgrade
" - Update der Plugins mit PlugUpdate

call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug 'dracula/vim', { 'as': 'dracula' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI aufpeppen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Key Combis anzeigen
Plug 'liuchengxu/vim-which-key'

" Zeige die offenen Buffers in der VIM-line - eleganter Ersatz für Tabs
Plug 'bling/vim-bufferline'

" Schlankes Powerline-replacement für VIM
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Sinnvolle Startseite
Plug 'mhinz/vim-startify'

" Projekt root finden
Plug 'airblade/vim-rooter'

" Hervorheben einer yank region
Plug 'machakann/vim-highlightedyank'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allgemeines für VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lokale VIM Konfiguration für meine Projektverzeichnisse
Plug 'embear/vim-localvimrc'

" Änderungen markieren
Plug 'mhinz/vim-signify'

" :Git tools.
Plug 'tpope/vim-fugitive'

" Direkter Support von GPG verschlüsselten Textdateien
Plug 'jamessan/vim-gnupg'

" Komfortable Diffs über Verzeichnisse
Plug 'will133/vim-dirdiff', { 'on': ['DirDiff'] }

" Highlight eines eindeutigen Zeichens bei f,F,t,T
Plug 'unblevable/quick-scope'
" TODO Not working with the current style?

" Mit ctrl-n mehrere Cursor für das Wort unterm Cursor erzeugen
" Plug 'terryma/vim-multiple-cursors'

" Universeller Fuzzy Finder für Files, Grep, Git, ... - beide Plugins nötig
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Whitespaces besser highlighten - Achtung: scroll performance.
" Plug 'ntpeters/vim-better-whitespace'

" Views automatisch erstellen um Folds usw zu erhalten
Plug 'vim-scripts/restore_view.vim'

" Neo-tree and its dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v3.x' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Programmierzeugs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sprachsupport für viele der gängigen Sprachen. Darunter GLSL, C++11/14/17/..., cmake
Plug 'sheerun/vim-polyglot'

" Doxygen Kommentare aus der Signatur erzeugen.
" Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Ultimatives auto completion plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" C# Support. Dependencies und Doku, siehe plugins/omnisharp-vim.vim
" Plug 'OmniSharp/omnisharp-vim'

" Code formatter
Plug 'sbdchd/neoformat'

" Farben anzeigen
" Slows down drastically:
"Plug 'chrisbra/Colorizer'
"Plug 'uga-rosa/ccc.nvim', { 'branch': '0.7.2' }

" Erzeugt einen überblick über aktuellen namespace,function,usw.
" Warn: scroll performance.
" Plug 'wellle/context.vim'

" Das wars.
call plug#end()

