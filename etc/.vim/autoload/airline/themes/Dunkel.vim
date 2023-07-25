let g:airline#themes#Dunkel#palette = {}

function! airline#themes#Dunkel#refresh()

    " generate_color_map hat 3 params und entspricht von außen nach innen
    " 1 > 2 > 33333 < 2 < 1

    " Basis Hintergrundfarben aus diesen Theme Gruppen beziehen:
    let colN = airline#themes#get_highlight('FoldColumn')
    let colI = airline#themes#get_highlight('Visual')

    " Statuszeilenfarben für die inneren Sektionen
    let colB = airline#themes#get_highlight('StatusLine')
    let colC = airline#themes#get_highlight('StatusLineNC')

    " Farben für die Fehler und Warnungen
    let error_group = airline#themes#get_highlight('ErrorMsg')
    let colErr = [ 'white', error_group[0], 'white', error_group[3] ]
    let warn_group = airline#themes#get_highlight('WarningMsg')
    let colWarn = [ 'black', warn_group[0], 'black', warn_group[3] ]


    " Die Farben der Sektionen zusammenbauen
    " ACHTUNG: scheinbar verdreht airline die Reihenfolge von fg und bg im VIM
    " terminal modus.
    let s:N1 = [ 'white', colN[0], 'white', colN[2] ]
    let s:N2 = [ colB[0], colB[1], colB[3], colB[2] ]
    let s:N3 = [ colC[0], colC[1], colC[3], colC[2] ]
    
    " ACHTUNG: irgendwie ist das hier nun wieder anders rum. 
    let s:I1 = [ 'white', colI[1], 'white', colI[2] ]
    let s:I2 = s:N2
    let s:I3 = s:N3

    let s:R1 = [ 'white', colI[1], 'white', colI[2] ]
    let s:R2 = s:N2
    let s:R3 = s:N3

    let s:V1 = [ colI[1], colI[0], colI[2], colI[3] ]
    let s:V2 = s:N2
    let s:V3 = s:N3

    " Inactive
    let s:IA = s:N3

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "
    " Setzen der Farben
    "
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


    " Normal Mode:
    let g:airline#themes#Dunkel#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

    " Oder kein Eintrag um keine Farbänderung für modifizierte Buffer zuzulassen
    let g:airline#themes#Dunkel#palette.normal_modified = {}

    " Warning Sektion
    let g:airline#themes#Dunkel#palette.normal.airline_warning = colWarn
    let g:airline#themes#Dunkel#palette.normal_modified.airline_warning = colWarn

    " Error Sektion
    let g:airline#themes#Dunkel#palette.normal.airline_error = colErr
    let g:airline#themes#Dunkel#palette.normal_modified.airline_error = colErr

    " Insert
    let g:airline#themes#Dunkel#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
    let g:airline#themes#Dunkel#palette.insert_modified = g:airline#themes#Dunkel#palette.normal_modified
    let g:airline#themes#Dunkel#palette.insert.airline_warning = g:airline#themes#Dunkel#palette.normal.airline_warning
    let g:airline#themes#Dunkel#palette.insert_modified.airline_warning = g:airline#themes#Dunkel#palette.normal_modified.airline_warning
    let g:airline#themes#Dunkel#palette.insert.airline_error = g:airline#themes#Dunkel#palette.normal.airline_error
    let g:airline#themes#Dunkel#palette.insert_modified.airline_error = g:airline#themes#Dunkel#palette.normal_modified.airline_error

    " Replace = Insert Mode + Einfg
    let g:airline#themes#Dunkel#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
    let g:airline#themes#Dunkel#palette.replace_modified = g:airline#themes#Dunkel#palette.normal_modified
    let g:airline#themes#Dunkel#palette.replace.airline_warning = g:airline#themes#Dunkel#palette.normal.airline_warning
    let g:airline#themes#Dunkel#palette.replace_modified.airline_warning = g:airline#themes#Dunkel#palette.normal_modified.airline_warning
    let g:airline#themes#Dunkel#palette.replace.airline_error = g:airline#themes#Dunkel#palette.normal.airline_error
    let g:airline#themes#Dunkel#palette.replace_modified.airline_error = g:airline#themes#Dunkel#palette.normal_modified.airline_error

    " Auswahlmodus
    let g:airline#themes#Dunkel#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
    let g:airline#themes#Dunkel#palette.visual_modified = g:airline#themes#Dunkel#palette.normal_modified
    let g:airline#themes#Dunkel#palette.visual.airline_warning = g:airline#themes#Dunkel#palette.normal.airline_warning
    let g:airline#themes#Dunkel#palette.visual_modified.airline_warning = g:airline#themes#Dunkel#palette.normal_modified.airline_warning
    let g:airline#themes#Dunkel#palette.visual.airline_error = g:airline#themes#Dunkel#palette.normal.airline_error
    let g:airline#themes#Dunkel#palette.visual_modified.airline_error = g:airline#themes#Dunkel#palette.normal_modified.airline_error

    " Wenn das Fenster nicht aktiv ist
    let g:airline#themes#Dunkel#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

    " Rote Akzentfarbe. Wofür ist die da?
    let g:airline#themes#Dunkel#palette.accents = {
                \ 'red': airline#themes#get_highlight('Constant'),
                \ }
endfunction

call airline#themes#Dunkel#refresh()

