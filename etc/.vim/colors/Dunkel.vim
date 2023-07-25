set background=dark
if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

"set t_Co=256
let g:colors_name = "Dunkel"

"{{{ GUI

" Hintergund ohne text
hi NonText guifg=#5b5b5c guibg=#1b1b1c guisp=#181818 gui=NONE ctermfg=241 ctermbg=234 cterm=NONE
" Text - Alternatives #1b1b1c, 1f1e1f
hi Normal guifg=#e4e4e4 guibg=#1b1b1c guisp=#181818 gui=NONE ctermfg=254 ctermbg=234 cterm=NONE

" Unprintable Symbols - tabs und so wenn set list.
hi SpecialKey guifg=#363636 guibg=NONE guisp=NONE gui=bold ctermfg=235 ctermbg=NONE cterm=bold

" Aufklapp Menüs (Codevervollständigung und so)
hi PMenu guifg=#d0d0d0 guibg=#2a2a2c guisp=NONE gui=NONE ctermfg=252 ctermbg=235 cterm=NONE
hi PMenuThumb guifg=NONE guibg=#585858 guisp=NONE gui=NONE ctermfg=NONE ctermbg=240 cterm=NONE
hi PMenuSbar guifg=NONE guibg=#2a2a2c guisp=NONE gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE
hi PMenuSel guifg=#ffaf00 guibg=#3a3a3a guisp=#3a3a3a gui=bold ctermfg=214 ctermbg=237 cterm=bold

" Falten
hi Folded guifg=#eeeeee guibg=#363637 guisp=NONE gui=bold ctermfg=254 ctermbg=237 cterm=bold
hi FoldColumn guifg=#005f87 guibg=#19191a guisp=NONE gui=bold ctermfg=24 ctermbg=234 cterm=NONE

" Wildmenu Completion
" -> Ausgewähltes element:
hi WildMenu guifg=#ffaf00 guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold

" Statuslines
hi StatusLineNC guifg=#8a8a8a guibg=#262626 gui=NONE ctermfg=245 ctermbg=235 cterm=NONE
hi StatusLine guifg=#bcbcbc guibg=#303030   gui=NONE ctermfg=250 ctermbg=236 cterm=NONE

" Balken für vertikale Trennung (:vertical sb)
hi VertSplit guifg=#000000 guibg=#585858 guisp=#080808 gui=NONE ctermfg=0 ctermbg=240 cterm=NONE

" Tabbing - GUI und Text Reiter
"hi TabLineSel -- no settings --
"hi TabLineFill -- no settings --
"hi TabLine -- no settings --

" Warnungen, Ausgaben und Fehler in der Kommandozeile
"hi ErrorMsg guifg=#d70000 guibg=NONE guisp=NONE gui=Bold ctermfg=160 ctermbg=NONE cterm=bold
hi ErrorMsg guifg=#cd2147 guibg=NONE  gui=bold ctermfg=167 ctermbg=NONE cterm=bold

hi WarningMsg guifg=#ffaf00 guibg=NONE guisp=NONE gui=Bold ctermfg=226 ctermbg=NONE cterm=bold
hi ModeMsg guifg=#eeeeee guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
hi MoreMsg guifg=#87d75f guibg=NONE guisp=NONE gui=NONE ctermfg=113 ctermbg=NONE cterm=NONE

" Title bei langen Ausgaben in Kommandozeile
hi Title guifg=#ffaf00 guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE

" Fragen in der Kommandozeile
hi Question guifg=#87d75f guibg=NONE guisp=NONE gui=bold ctermfg=113 ctermbg=NONE cterm=bold

" Zeilennummer
hi LineNr guifg=#555557 guibg=#19191a guisp=NONE gui=NONE ctermfg=237 ctermbg=234 cterm=NONE

" Cursor
" Hervorhebung der Spalte des Cursors
"hi CursorColumn -- no settings --
" Der eigentliche Cursor
hi Cursor guifg=NONE guibg=#bcbcbc guisp=#bcbcbc gui=NONE ctermfg=NONE ctermbg=250 cterm=NONE
" Aktuelle Zeile
hi CursorLine guibg=#262626  ctermbg=235 cterm=NONE
hi CursorLineNR guifg=#eeeeee gui=bold ctermfg=255 cterm=bold

" Markierung von überlangem Text
"hi overlength guisp=#af0000 gui=undercurl ctermfg=255 ctermbg=124 cterm=NONE
hi colorcolumn guifg=NONE guibg=#19191a guisp=NONE gui=NONE ctermfg=NONE ctermbg=233 cterm=NONE
hi overlength  guibg=#5f0000 ctermbg=052

" Suche
hi IncSearch     guifg=#ffaf00 guibg=NONE gui=bold                    ctermfg=214 ctermbg=NONE cterm=bold
hi Search        guifg=#ffaf00 guibg=NONE gui=bold                    ctermfg=214 ctermbg=NONE cterm=bold
hi SearchCurrent guifg=#262626 guibg=#ff5f00                          ctermfg=NONE ctermbg=202

" Spalte für Markierungen, neben der Zeilennummer
hi SignColumn guifg=NONE guibg=#19191a guisp=NONE gui=NONE ctermfg=NONE ctermbg=234 cterm=NONE

" Spell
hi SpellCap   guifg=NONE guibg=NONE guisp=#005fff gui=undercurl ctermfg=27 ctermbg=NONE cterm=underline
hi SpellRare  guifg=NONE guibg=NONE guisp=#ffff87 gui=undercurl ctermfg=228 ctermbg=NONE cterm=underline
hi SpellLocal guifg=NONE guibg=NONE guisp=#d70087 gui=undercurl ctermfg=162 ctermbg=NONE cterm=underline
hi SpellBad   guifg=NONE guibg=NONE guisp=#d24d4d gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl

" Diff
"hi DiffAdd guifg=NONE guibg=#4e4e4e guisp=#4e4e4e gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
"hi DiffChange guifg=#eeeeee guibg=#303030 guisp=#303030 gui=NONE ctermfg=255 ctermbg=236 cterm=NONE
"hi DiffDelete guifg=#eeeeee guibg=#303030 guisp=#303030 gui=bold ctermfg=255 ctermbg=236 cterm=bold
"hi DiffText guifg=#ffffff guibg=#af5f5f guisp=#af5f5f gui=NONE ctermfg=15 ctermbg=131 cterm=NONE
" Diff for gitcommit
"hi diffRemoved guifg=#f43753 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"hi diffChanged guifg=#b3deef ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"hi diffAdded guifg=#c9d05c ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"hi diffSubname guifg=#9faa00 ctermfg=142 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiffAdd    guifg=NONE    guibg=#303031 gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
hi DiffDelete guifg=#f43753 guibg=#79313c gui=NONE ctermfg=203  ctermbg=237 cterm=NONE
hi DiffChange guifg=NONE    guibg=#303031 gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
hi DiffText   guifg=#e4e4e4 guibg=#3a6279 gui=BOLD ctermfg=NONE ctermbg=131 cterm=BOLD

" Klammern hervorheben
hi MatchParen guifg=#262626 guibg=#ffaf00 guisp=#ffaf00 gui=NONE ctermfg=235 ctermbg=214 cterm=NONE

" Visual mode
hi Visual guifg=NONE guibg=#585858 guisp=#585858 gui=NONE ctermfg=NONE ctermbg=240 cterm=NONE
hi VisualNOS guifg=NONE guibg=#585858 guisp=#585858 gui=NONE ctermfg=NONE ctermbg=240 cterm=NONE
"}}}

"{{{ Syntax

" Kommentare und enthaltene highlights
hi Comment        guifg=#626262 guibg=NONE guisp=NONE gui=bold ctermfg=240 ctermbg=NONE cterm=bold
hi SpecialComment guifg=#767676 guibg=NONE guisp=NONE gui=bold ctermfg=242 ctermbg=NONE cterm=bold
hi Todo           guifg=#ffaf00 guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold

" Sprachelemente
hi Function     guifg=#eeeeee guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
hi Identifier   guifg=#eeeeee guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE

" Alternativen: #2f91cd, #1da4f5 , 0087d7, 4a88cc

hi Statement    guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Keyword      guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Constant     guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold

hi Operator     guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Exception    guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Conditional  guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Repeat       guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Structure    guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi StorageClass guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Typedef      guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Label        guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold

" Interne Typbezeichner wie char, int usw
hi Type         guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold

" Typen
hi Number       guifg=#72a31a guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
hi Float        guifg=#72a31a guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
hi Boolean      guifg=#72a31a guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
hi Character    guifg=#72a31a guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
"hi String       guifg=#94afc0 guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=italic
"hi String       guifg=#72a31a guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
hi String       guifg=#9cc370 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=bold

" Preprocessor
"hi PreProc      guifg=#ffaf00 guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold
hi PreProc      guifg=#dadada guibg=NONE guisp=NONE gui=bold ctermfg=254 ctermbg=NONE cterm=bold
"hi PreCondit    guifg=#ffaf00 guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold
"hi PreCondit      guifg=#dadada guibg=NONE guisp=NONE gui=bold ctermfg=254 ctermbg=NONE cterm=bold
hi PreCondit    guifg=#dadada guibg=#2e546f guisp=NONE gui=bold ctermfg=254 ctermbg=24 cterm=bold
hi Include      guifg=#dadada guibg=NONE guisp=NONE gui=bold ctermfg=254 ctermbg=NONE cterm=bold
hi Define       guifg=#dadada guibg=NONE guisp=NONE gui=bold ctermfg=254 ctermbg=NONE cterm=bold
hi Macro        guifg=#dadada guibg=NONE guisp=NONE gui=bold ctermfg=254 ctermbg=NONE cterm=bold

"{{{ ???

" Verzeichnisse
" Hinweis: wird in QuickFix und so benutzt.
hi Directory guifg=#4a88cc guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold

" Sonderzeichen und spezielle Symbole
hi SpecialChar guifg=#eeeeee guibg=NONE guisp=NONE gui=bold ctermfg=255 ctermbg=NONE cterm=bold
hi Special guifg=#eeeeee guibg=NONE guisp=NONE gui=bold ctermfg=255 ctermbg=NONE cterm=bold

" ? - Doc sagt "character that needs attention"
hi Delimiter guifg=#8a8a8a guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE

" Debug Code
hi Debug guifg=#8a8a8a guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE

" Tag Markierungen
hi Tag guifg=#8a8a8a guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE

" Sonstige Anzeigen/Highlights
"hi Error    guifg=#eeeeee guibg=#d70000 guisp=#df0000 gui=NONE ctermfg=255 ctermbg=160 cterm=NONE
hi Error    guifg=#cd2147 guibg=NONE  gui=bold ctermfg=167 ctermbg=NONE cterm=bold

"}}}

"{{{ CPP Spezifisch

hi link cppAccess           cppStatement
hi link cppCast             cppStatement
hi link cppExceptions       Exception
hi link cppOperator         Operator
hi link cppStatement        Statement
hi link cppType             Type
hi link cppStorageClass     StorageClass
hi link cppStructure        Structure
hi link cppBoolean          Boolean
hi link cppConstant         Constant
hi link cppRawDelimiter     Delimiter
hi link cppRawString        String

hi link cppSTLfunction      Function
hi link cppSTLfunctional    Typedef
hi link cppSTLconstant      Constant
hi link cppSTLnamespace     Keyword
hi link cppSTLtype          Typedef
hi link cppSTLexception     Exception
hi link cppSTLiterator      Typedef
hi link cppSTLiterator_tag  Typedef
hi link cppSTLenum          Typedef
hi link cppSTLios           Function
hi link cppSTLcast          Statement

"}}}

"{{{ VIM Spezifisch

hi link vimOption Identifier
hi link vimEnvvar Identifier

hi link vimBufnrWarn WarningMsg
hi link vimHiAttrib Number
"vimCommentTitle
hi link vimHLMod Number

"}}}

"{{{ Doxygen spezifisch
hi doxyParam guifg=#b2b2b2 guibg=NONE guisp=NONE gui=bold ctermfg=249 ctermbg=NONE cterm=bold
hi doxyCommentB guifg=#8a8a8a guibg=NONE guisp=NONE gui=bold ctermfg=245 ctermbg=NONE cterm=bold
hi doxyKeyword guifg=#b2b2b2 guibg=NONE guisp=NONE gui=bold ctermfg=249 ctermbg=NONE cterm=bold
hi doxyParamName guifg=#d0d0d0 guibg=NONE guisp=NONE gui=bold ctermfg=252 ctermbg=NONE cterm=bold

hi link doxyString  doxyParamName
hi link doxyComment Comment
hi link doxyError   Error

hi link doxygenBody doxyComment
hi link doxygenSpecial doxyComment

hi link doxygenParamName doxyString
hi link doxygenParam doxyParam

hi link doxygenSpecialOnelineDesc doxyComment
hi link doxygenSpecialTypeOnelineDesc doxyComment
hi link doxygenSpecialMultilineDesc doxyComment

hi link doxygenStart doxyComment
hi link doxygenComment doxyComment

hi link doxygenPrev doxyComment
hi link doxygenBriefL doxyComment
hi link doxygenBriefLine doxyCommentB
hi link doxygenBrief doxyCommentB
hi link doxygenBriefWord doxyKeyword

hi link doxygenSpecialHeading doxyComment
hi link doxygenContinueComment doxyComment
hi link doxygenLinkWord doxyComment
hi link doxygenBOther doxyComment
hi link doxygenPageIdent doxyComment
hi link doxygenOther doxyParam

hi link doxygenErrorComment doxyError
hi link doxygenLinkError doxyError
"}}}

"}}}

"{{{ Plugins

"{{{ YouCompleteMe

" Fehler
hi YcmErrorSign         guifg=#cd2147 guibg=#1c1c1c guisp=NONE gui=bold ctermfg=167 ctermbg=234 cterm=bold

" Die Zeile des Fehlers:
" hi link YcmErrorLine showmarkshll

" Die eigentliche Textpassage
hi YcmErrorSection      guisp=#cd2147 gui=undercurl ctermfg=167 cterm=underline

" Warnings
hi YcmWarningSign         guifg=#ffaf00 guibg=#1c1c1c guisp=NONE gui=bold ctermfg=214 ctermbg=234 cterm=bold

" Die Zeile des Fehlers:
" hi link YcmErrorLine showmarkshll

" Die eigentliche Textpassage
hi YcmWarningSection guisp=#ff8700 gui=undercurl ctermfg=208 cterm=underline

"}}}

"{{{ Signify

" Signs
hi SignifySignAdd        guifg=#5d9a34 guibg=#19191a guisp=NONE gui=bold ctermfg=243 ctermbg=234 cterm=bold
hi SignifySignChange     guifg=#757b81 guibg=#19191a guisp=NONE gui=bold ctermfg=243 ctermbg=234 cterm=bold
hi SignifySignDelete     guifg=#c1433a guibg=#19191a guisp=NONE gui=bold ctermfg=160 ctermbg=234 cterm=bold
hi link SignifySignDeleteFirstLine SignifySignDelete

"hi DiffAdd        guibg=#5d9a34 guifg=#19191a guisp=NONE gui=bold ctermfg=243 ctermbg=234 cterm=bold
"hi DiffChange     guibg=#757b81 guifg=#19191a guisp=NONE gui=bold ctermfg=243 ctermbg=234 cterm=bold
"hi DiffDelete     guibg=#c1433a guifg=#19191a guisp=NONE gui=bold ctermfg=160 ctermbg=234 cterm=bold
"hi DiffText guifg=#ffffff guibg=#af5f5f guisp=#af5f5f gui=NONE ctermfg=15 ctermbg=131 cterm=NONE

"}}}

"{{{ Hightlight Yank

highlight HighlightedyankRegion cterm=reverse gui=reverse

"}}}
