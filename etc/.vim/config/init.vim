" Variante mit relativem pfad zu diesem script:
"let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
"execute "source ".s:path."/plugins.vim"

" Einige Plugins müssen vor deren initialisierung konfiguriert werden:
for rcfile in split(globpath("~/.vim/config/plugins/pre", "*.vim"), '\n')
    execute('source '.rcfile)
endfor

" Plugin Konfiguration.
source $HOME/.vim/config/plugins.vim

" Kleine Helfer und aliase.
source $HOME/.vim/config/miniplugs.vim

" Die eigentliche VIM Konfiguration
source $HOME/.vim/config/behavior.vim

" Ein paar macken gerade büglen
source $HOME/.vim/config/quirks.vim

" Tasten
" <Leader> Taste ist ,. Wenn nicht gesetzt, "\" ist der default.
source $HOME/.vim/config/keys.vim

" Konfiguration der Plugins
for rcfile in split(globpath("~/.vim/config/plugins", "*.vim"), '\n')
    execute('source '.rcfile)
endfor

" Statuszeile und Farben
source $HOME/.vim/config/style.vim
