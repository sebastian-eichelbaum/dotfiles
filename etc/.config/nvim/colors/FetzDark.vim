let g:colors_name = "FetzDark"

"{{{ Boilerplate
set background=dark

highlight clear
if exists("syntax_on")
    syntax reset
endif
"}}}

"{{{ Helpers

" Call for a given highlight group.
" param 1: the group name
" param 2: fg color
" param 3: optional, bg color
" param 4: optional, attributes like bold, undercurl, ...
" param 5: optional, special color (i.e. the undercurl color)
function! s:hi(group, fg, ...)
    " Mostly taken from the dracula theme at https://github.com/dracula

    " If special attrs are supported
    " TODO: this is a hack. gui_running is false in neovim although the full
    " guisp support is given
    let l:has_full_special_attrs_support = 1 " has('gui_running')

    let l:fg = copy(a:fg)
    let l:bg = get(a:, 1, ['NONE', 'NONE'])

    let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
    let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

    " If the UI does not have full support for special attributes (like underline and
    " undercurl) and the highlight does not explicitly set the foreground color,
    " make the foreground the same as the attribute color to ensure the user will
    " get some highlight if the attribute is not supported. The default behavior
    " is to assume that terminals do not have full support, but the user can set
    " the global variable `l:has_full_special_attrs_support` explicitly if the
    " default behavior is not desirable.
    let l:special = get(a:, 3, ['NONE', 'NONE'])
    if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !l:has_full_special_attrs_support
        let l:fg[0] = l:special[0]
        let l:fg[1] = l:special[1]
    endif

    let l:hl_gui = [
        \ 'guifg=' .   l:fg[0],
        \ 'guibg=' .   l:bg[0],
        \ 'gui=' .     l:attrs,
        \ 'guisp=' .   l:special[0],
        \]

    let l:hl_cterm = [
        \ 'ctermfg=' . l:fg[1],
        \ 'ctermbg=' . l:bg[1],
        \ 'cterm=' .   l:attrs,
        \]

    let l:hl_string = 'highlight '. a:group . " " . join(l:hl_gui, ' ')
    " Add terminal?
    let l:hl_string = l:hl_string . ' ' . join(l:hl_cterm, ' ')

    execute l:hl_string
endfunction

" A No-Color
let s:none      = ['NONE', 'NONE']

" Abbreviate the usual attributes
let s:attrs = {
      \ 'b': 'bold',
      \ 'i': 'italic',
      \ 'u': 'underline',
      \ 'c': 'undercurl',
      \ 'inv': 'inverse',
      \}
"}}}

"{{{

" Use CccHighlighterEnable to show the colors.
" Use :call ConvertHexToX11 to get the X11 color value for the hex string under
" the cursor. Defined in miniplugs.vim

"{{{ Color Palette
let s:palette                          = {}

"{{{ FG and BG and some shades

let s:palette.fg                       = ['#e4e4e4', 254]
let s:palette.fgD1                     = ['#bcbcbc', 250]
let s:palette.fgD2                     = ['#8a8a8a', 245]
let s:palette.fgD3                     = ['#626262', 241]
let s:palette.fgD4                     = ['#555557', 239]

let s:palette.bgL3                     = ['#585858', 240]
let s:palette.bgL2                     = ['#363637', 237]
let s:palette.bgL1                     = ['#262626', 235]
let s:palette.bg                       = ['#1b1b1c', 234]
let s:palette.bgD1                     = ['#19191a', 233]

"}}}

"{{{ Core color scheme

" A eye-pain inducing color used to flag unset or unknown highlights
let s:palette.wtf                      = ['#ff00ff', 201]

" A primary color used for statements, keywords and other, important,
" structural elements.
let s:palette.primary                  = ['#4a88cc', 68]
let s:palette.primaryBG                = ['#27323e', 236]
" An primary variant for UI elements - bit more subtle as BG
let s:palette.primaryVariant           = ['#005f87', 24]

" A secondary color is used to denote values and things that are not
" the most important things.
let s:palette.secondary                = ['#85b038', 107]
let s:palette.secondaryBG              = ['#303329', 236]
" The variant of secondary is used to distinguish strings
let s:palette.secondaryVariant         = ['#a2bf6d', 143]

" Some color for some ui elements and stuff without a particular meaning
let s:palette.tertiary                 = ['#bf68ed', 135]
let s:palette.tertiaryBG               = ['#382b3e', 237]

" Make things unobtrusive. Nice-to-know things that should not attract the
" immediate focus of the user. I.e. hints, comments, ...
let s:palette.unobtrusive              = ['#626262', 241]
let s:palette.unobtrusiveBG            = ['#363637', 237]
let s:palette.unobtrusiveVariant       = ['#8a8a8a', 245]

" A highlight color is used to mark things of non-permanent importance like
" warnings or search highlight         .
let s:palette.attention                = ['#e79d31', 179]
let s:palette.attentionBG              = ['#3c2e1b', 236]

" Color denoting critical issues
let s:palette.critical                 = ['#ed3b44', 203]
let s:palette.criticalBG               = ['#3e262d', 236]

"}}}

"{{{ Severities of messages

" Colors used to denote messages of different severities. Derived from the
" core color scheme.

let s:palette.error                    = s:palette.critical
let s:palette.errorBG                  = s:palette.criticalBG

let s:palette.warn                     = s:palette.attention
let s:palette.warnBG                   = s:palette.attentionBG

let s:palette.info                     = s:palette.unobtrusive
let s:palette.infoBG                   = s:palette.unobtrusiveBG

let s:palette.hint                     = s:palette.unobtrusive
let s:palette.hintBG                   = s:palette.unobtrusiveBG

"}}}

"{{{ Vim UI elements and functions

" These are derived from the core color scheme and provide a common color to
" some vim UI elements or ui concepts like selection and highlighting.

let s:palette.highlight                = s:palette.attention
let s:palette.highlightBG              = s:palette.attentionBG

" The sidebar elements like fold/sign/linenr/... column
let s:palette.sideBG                   = s:palette.bgD1

let s:palette.selectionFG              = s:palette.fg
let s:palette.selectionBG              = s:palette.bgL3

" PMenu and Wildcard - ever so slightly blue-ish grey
let s:palette.popupBGL1                = ['#555558', 240]
let s:palette.popupBG                  = ['#333337', 237]
let s:palette.popupBGD1                = ['#2a2a2e', 236]
let s:palette.popupBGD2                = ['#222226', 235]
let s:palette.popupFG                  = ['#bbbbbb', 250]

"}}}

"}}}

"{{{ Editor Base Style

" Export some palette entries as highlight groups to be accessible from other
" themes (like airline themes)
call s:hi("FetzDarkPrimary",           s:palette.primary,            s:palette.primaryVariant)
call s:hi("FetzDarkAirlineError",      s:palette.errorBG,            s:palette.error,              [s:attrs.b])
call s:hi("FetzDarkAirlineWarn",       s:palette.warnBG,             s:palette.warn,               [s:attrs.b])
call s:hi("WTF",                       s:palette.fg,                 s:palette.wtf)



" These are the styles that describe the editor and text-content itself
" without any code syntax elements.

"{{{ Basic Text Content

call s:hi("Normal",                    s:palette.fg,                 s:palette.bg)
" Background without any text. The FG color
call s:hi("NonText",                   s:palette.fgD4,               s:palette.bg,                 [s:attrs.b])

" Unprintable Symbols - tabs and stuff like that. Refer to listchars, the
" highlight group 'Whitespace' might be interesting here.
call s:hi("SpecialKey",                s:none,                       s:none,                       [s:attrs.b])
hi! link SpecialChar                   SpecialKey
hi! link Special                       SpecialKey

"}}}

"{{{ Cursor

call s:hi("Cursor",                    s:none,                       s:palette.fg)
call s:hi("CursorLine",                s:none,                       s:palette.bgL1)
" The current line number in the sidebar
call s:hi("CursorLineNR",              s:palette.fg,                 s:palette.sideBG,             [s:attrs.b])
" Activate via 'set cursorcolumn'
call s:hi("CursorColumn",              s:none,                       s:palette.bgL1)

"}}}

"{{{ Visual mode

call s:hi("Visual",                    s:none,                       s:palette.selectionBG)
" Non-owning selections. This matches in GUIs where the X selection differs
" from vim's selection.
call s:hi("VisualNOS",                 s:none,                       s:palette.selectionBG)

"}}}

"{{{ Search and matches

call s:hi("IncSearch",                 s:palette.highlight,          s:none,                       [s:attrs.b])
call s:hi("Search",                    s:palette.highlight,          s:none,                       [s:attrs.b])
" The search result at the cursor
call s:hi("CurSearch",                 s:palette.highlight,          s:none,                       [s:attrs.inv])

call s:hi("MatchParen",                s:palette.highlight,          s:none,                       [s:attrs.inv])

"}}}

"{{{ Spell

call s:hi("SpellCap",                  s:none,                       s:none,                       [s:attrs.c],                  s:palette.warn)
call s:hi("SpellRare",                 s:none,                       s:none,                       [s:attrs.c],                  s:palette.hint)
call s:hi("SpellLocal",                s:none,                       s:none,                       [s:attrs.c],                  s:palette.warn)
call s:hi("SpellBad",                  s:none,                       s:none,                       [s:attrs.c],                  s:palette.error)

"}}}

" {{{ Diff

call s:hi("DiffChange",                s:none,                       s:palette.bgL2)
call s:hi("DiffAdd",                   s:none,                       s:none)
call s:hi("DiffDelete",                s:palette.critical,           s:palette.criticalBG)
call s:hi("DiffText",                  s:none,                       s:palette.bgL3,               [s:attrs.b])

" }}}

"{{{ GUI Elements - Bars and Widgets

call s:hi("Folded",                    s:palette.fg,                 s:palette.bgL2,               [s:attrs.b])

call s:hi("Error",                     s:palette.error,              s:none,                       [s:attrs.b])
call s:hi("Warning",                   s:palette.warn,               s:none,                       [s:attrs.b])
call s:hi("Hint",                      s:palette.hint,               s:none,                       [s:attrs.b])
call s:hi("Info",                      s:palette.info,               s:none,                       [s:attrs.b])

"}}}
"
"{{{ GUI Elements - Windows, Floats and Splits

" The bar when splitting vertically (:vsplit). 
call s:hi("VertSplit",                 s:palette.bgL3,               s:none,                       [])
" Separators between window splits.
hi! link WinSeparator  VertSplit
" Floating window border
hi! link FloatBorder  VertSplit
"FloatTitle
"FloatFooter

"}}}

"{{{ Side column content

" Left to right.

call s:hi("FoldColumn",                s:palette.fgD3,               s:palette.sideBG,             [s:attrs.b])
call s:hi("SignColumn",                s:none,                       s:palette.sideBG)
" Line numbers. The CursorLineNR group handles the cursor sidebar appearance
call s:hi("LineNr",                    s:palette.fgD4,               s:palette.sideBG)
" The textwidth column.
call s:hi("ColorColumn",               s:none,                       s:palette.sideBG)

"}}}

"{{{ Statusline

call s:hi("StatusLine",                s:palette.fgD1,               s:palette.bgL2)
" Statusline for non-current windows
call s:hi("StatusLineNC",              s:palette.fgD2,               s:palette.bgL1)

"}}}

"{{{ Commandline

call s:hi("ErrorMsg",                  s:palette.error,              s:none,                       [s:attrs.b])
call s:hi("WarningMsg",                s:palette.warn,               s:none,                       [s:attrs.b])
call s:hi("ModeMsg",                   s:none,                       s:none)
call s:hi("MoreMsg",                   s:none,                       s:none,                       [s:attrs.b])

" The title used when printing long lists (like :set all)
call s:hi("Title",                     s:palette.info,               s:none,                       [s:attrs.b])
" Whenever a question or prompt is shown on the command line
call s:hi("Question",                  s:none,                       s:none,                       [s:attrs.b])

"}}}

"{{{ Tabbing

"hi TabLineSel -- no settings --
"hi TabLineFill -- no settings --
"hi TabLine -- no settings --

"}}}

"{{{ Popup Menus

call s:hi("PMenu",                     s:palette.popupFG,            s:palette.popupBG)
" Scrollbar Thumb
call s:hi("PMenuThumb",                s:none,                       s:palette.popupBGL1)
" Scrollbar BG
call s:hi("PMenuSbar",                 s:none,                       s:palette.popupBGD2)
" Selected
call s:hi("PMenuSel",                  s:palette.selectionFG,        s:palette.selectionBG,        [s:attrs.b])
call s:hi("WildMenu",                  s:palette.wtf,                s:palette.wtf,                [s:attrs.b])

"}}}

"}}}

" {{{ More ...
" More styles that are not really syntactical elements

" Directory names (and other special names in listings)
call s:hi("Directory",                 s:palette.primary,            s:none,                       [s:attrs.b])

" Debug Code
call s:hi("Debug",                     s:palette.wtf,                s:none,                       [s:attrs.i, s:attrs.b])
" Tag marks (jump via Ctrl-])
call s:hi("Tag",                       s:palette.wtf,                s:none,                       [s:attrs.i, s:attrs.b])

"}}}

"}}}

"{{{ Syntax

" Comments and comment variants.
call s:hi("Comment",                   s:palette.unobtrusive,        s:none,                       [s:attrs.b])
call s:hi("SpecialComment",            s:palette.unobtrusiveVariant, s:none,                       [s:attrs.b])
call s:hi("Todo",                      s:palette.attention,          s:none,                       [s:attrs.b])

" Usually used for special string delimiters. I.e. raw string delimiters in
" C++ and other languages
hi! link Delimiter                     Comment

" Free-text names with special meanings
hi! link Identifier                    NormalNC
hi! link Function                      Identifier

" Keywords and basic language elements
call s:hi("Keyword",                   s:palette.primary,            s:none,                       [s:attrs.b])
hi! link Statement                     Keyword
hi! link Operator                      Keyword
hi! link Exception                     Keyword
hi! link Conditional                   Keyword
hi! link Repeat                        Keyword
hi! link Structure                     Keyword
hi! link StorageClass                  Keyword
hi! link Typedef                       Keyword
hi! link Label                         Keyword

" Type names like int and such things.
hi! link Type                          Keyword
hi! link Constant                      Keyword

" Specific type VALUES
call s:hi("Number",                    s:palette.secondary,          s:none,                       [s:attrs.b])
hi! link Float                         Number
hi! link Boolean                       Number
hi! link Character                     Number
call s:hi("String",                    s:palette.secondaryVariant,   s:none,                       [])

" Preprocessor
call s:hi("PreProc",                   s:palette.fg,                 s:none,                       [s:attrs.b])
hi! link Include                       PreProc
hi! link Define                        PreProc
hi! link Macro                         PreProc
call s:hi("PreCondit",                 s:palette.fg,                 s:palette.bgL2,               [s:attrs.b],)

"{{{ CPP Specific

hi! link cppAccess                     cppStatement
hi! link cppCast                       cppStatement
hi! link cppExceptions                 Exception
hi! link cppOperator                   Operator
hi! link cppStatement                  Statement
hi! link cppType                       Type
hi! link cppStorageClass               StorageClass
hi! link cppStructure                  Structure
hi! link cppBoolean                    Boolean
hi! link cppConstant                   Constant
hi! link cppRawDelimiter               Delimiter
hi! link cppRawString                  String

hi! link cppSTLfunction                Function
hi! link cppSTLfunctional              Typedef
hi! link cppSTLconstant                Constant
hi! link cppSTLnamespace               Keyword
hi! link cppSTLtype                    Typedef
hi! link cppSTLexception               Exception
hi! link cppSTLiterator                Typedef
hi! link cppSTLiterator_tag            Typedef
hi! link cppSTLenum                    Typedef
hi! link cppSTLios                     Function
hi! link cppSTLcast                    Statement

"}}}

"{{{ VIM Specific

hi link vimOption                      Identifier
hi link vimEnvvar                      Identifier

hi link vimBufnrWarn                   WarningMsg
hi link vimHiAttrib                    Number
"vimCommentTitle
hi link vimHLMod                       Number

"}}}

"{{{ Doxygen Specific

call s:hi("doxyKeyword",               s:palette.fg,                 s:none,                       [s:attrs.b])
call s:hi("doxyLink",                  s:palette.unobtrusiveVariant, s:none,                       [s:attrs.b,s:attrs.i])

hi link doxyParam                      doxyKeyword
hi link doxyCommentB                   SpecialComment
hi link doxyParamName                  SpecialComment
hi link doxyString                     doxyParamName
hi link doxyComment                    Comment
hi link doxyError                      Error

hi link doxygenBody                    doxyComment
" The @ sign to start a keyword.
hi link doxygenSpecial                 doxyParam

hi link doxygenParamName               doxyString
hi link doxygenParam                   doxyParam

hi link doxygenSpecialOnelineDesc      doxyComment
hi link doxygenSpecialTypeOnelineDesc  doxyComment
hi link doxygenSpecialMultilineDesc    doxyComment

hi link doxygenStart                   doxyComment
hi link doxygenComment                 doxyComment

hi link doxygenPrev                    doxyComment
hi link doxygenBriefL                  doxyComment
hi link doxygenBriefLine               doxyCommentB
hi link doxygenBrief                   doxyCommentB
hi link doxygenBriefWord               doxyKeyword

hi link doxygenSpecialHeading          doxyComment
hi link doxygenContinueComment         doxyComment
hi link doxygenLinkWord                doxyLink
hi link doxygenRefWord                 doxyLink
hi link doxygenBOther                  doxyComment
hi link doxygenPageIdent               doxyComment
hi link doxygenOther                   doxyParam

hi link doxygenErrorComment            doxyError
hi link doxygenLinkError               doxyError
"}}}

"}}}

"{{{ Plugins

"{{{ COC
call s:hi("FDCocDiagnosticError",      s:palette.error,              s:palette.errorBG,            [s:attrs.b])
call s:hi("FDCocDiagnosticWarning",    s:palette.warn,               s:palette.warnBG,             [s:attrs.b])
call s:hi("FDCocDiagnosticInfo",       s:palette.info,               s:palette.infoBG,             [s:attrs.b])
call s:hi("FDCocDiagnosticHint",       s:palette.hint,               s:palette.hintBG,             [s:attrs.b])

" Diagnostic sidebar style
hi! link CocErrorSign                  FDCocDiagnosticError
hi! link CocWarningSign                FDCocDiagnosticWarning
hi! link CocInfoSign                   FDCocDiagnosticInfo
hi! link CocHintSign                   FDCocDiagnosticHint

" Diagnostic message style
hi! link DiagnosticError               FDCocDiagnosticError
call s:hi("DiagnosticUnderlineError",  s:none,                       s:none,                       [s:attrs.u],    s:palette.error)
hi! link DiagnosticWarn                FDCocDiagnosticWarning
call s:hi("DiagnosticUnderlineWarn",   s:none,                       s:none,                       [s:attrs.u],    s:palette.warn)
hi! link DiagnosticInfo                FDCocDiagnosticInfo
call s:hi("DiagnosticUnderlineInfo",   s:none,                       s:none,                       [s:attrs.u],    s:palette.info)
hi! link DiagnosticHint                FDCocDiagnosticHint
call s:hi("DiagnosticUnderlineHint",   s:none,                       s:none,                       [s:attrs.u],    s:palette.hint)

" Show unsued vars in that color.
call s:hi("CocUnusedHighlight",        s:palette.fgD2)


" Use Pemnu Style for all types of floats? This affects text FG color only.
"hi! link CocErrorFloat                 PMenu
"hi! link CocWarningFloat               PMenu
"hi! link CocHintFloat                  PMenu
"hi! link CocInfoFloat                  PMenu


" Style of the suggest popup:
hi! link CocSearch                     Keyword
hi! link CocMenuSel                    PMenuSel

call s:hi("FDCocFloatBorder",          s:palette.popupBGL1)
call s:hi("FDCocFloatSplitter",        s:palette.fgD4)

" Style of thise floating windows (diagnostic error/warnings and so on)
hi! link CocFloatDividingLine          FDCocFloatSplitter
hi! link CocFloating                   PMenu

" This is that [LS] thing in the suggest menu
call s:hi("FDCocPumShortcut",          s:palette.fgD4,               s:palette.popupBGD2,          [])
hi! link CocPumShortcut FDCocPumShortcut


call s:hi("FDCocSymbolCallable",       s:palette.tertiary,           s:palette.popupBGD2,          [s:attrs.b])
hi! link CocSymbolMethod               FDCocSymbolCallable
hi! link CocSymbolFunction             FDCocSymbolCallable
hi! link CocSymbolConstructor          FDCocSymbolCallable
hi! link CocSymbolModule               FDCocSymbolCallable

call s:hi("FDCocSymbolType",           s:palette.highlight,          s:palette.popupBGD2,          [s:attrs.b])
hi! link CocSymbolClass                FDCocSymbolType
hi! link CocSymbolStruct               FDCocSymbolType
hi! link CocSymbolInterface            FDCocSymbolType
hi! link CocSymbolEnum                 FDCocSymbolType
hi! link CocSymbolReference            FDCocSymbolType

call s:hi("FDCocSymbolValue",          s:palette.secondary,          s:palette.popupBGD2,          [s:attrs.b])
hi! link CocSymbolEnumMember           FDCocSymbolValue
hi! link CocSymbolTypeParameter        FDCocSymbolValue
hi! link CocSymbolText                 FDCocSymbolValue
hi! link CocSymbolValue                FDCocSymbolValue
hi! link CocSymbolNumber               FDCocSymbolValue
hi! link CocSymbolBoolean              FDCocSymbolValue
hi! link CocSymbolString               FDCocSymbolValue

call s:hi("FDCocSymbolVariable",       s:palette.fg,                 s:palette.popupBGD2,          [s:attrs.b])
hi! link CocSymbolConstant             FDCocSymbolVariable
hi! link CocSymbolVariable             FDCocSymbolVariable
hi! link CocSymbolField                FDCocSymbolVariable
hi! link CocSymbolProperty             FDCocSymbolVariable
hi! link CocSymbolEvent                FDCocSymbolVariable

call s:hi("FDCocSymbolKeyword",        s:palette.primary,            s:palette.popupBGD2,          [s:attrs.b])
hi! link CocSymbolKeyword              FDCocSymbolKeyword
hi! link CocSymbolOperator             FDCocSymbolKeyword


call s:hi("FDCocSymbolFiles",          s:palette.fg,                 s:palette.popupBGD2,          [s:attrs.b])
hi! link CocSymbolSnippet              FDCocSymbolFiles
hi! link CocSymbolFile                 FDCocSymbolFiles
hi! link CocSymbolFolder               FDCocSymbolFiles

hi! link CocSymbolKey                   WTF
hi! link CocSymbolUnit                  WTF
hi! link CocSymbolNull                  WTF
hi! link CocSymbolPackage               WTF
hi! link CocSymbolObject                WTF

hi! link CocSymbolArray                 WTF
hi! link CocSymbolColor                 WTF
hi! link CocSymbolNamespace             WTF


"}}}

"{{{ Signify

call s:hi("SignifySignAdd",            s:palette.secondary,          s:palette.sideBG,             [])
call s:hi("SignifySignChange",         s:palette.unobtrusive,        s:palette.sideBG,             [])
call s:hi("SignifySignDelete",         s:palette.critical,           s:palette.sideBG,             [])
hi link SignifySignDeleteFirstLine     SignifySignDelete

"}}}


"{{{ indent-blankline.nvim and others to denote vertical indentation levels and scopes

call s:hi("ScopeLine",                 s:palette.bgL2,               s:none,                       [])
call s:hi("IndentLine",                s:palette.bgL1,               s:none,                       [])

"}}}
