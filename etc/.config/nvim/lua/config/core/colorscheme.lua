-------------------------------------------------------------------------------
--
-- NeoVim Colorscheme setup
--
-------------------------------------------------------------------------------

-- Fiddle with it and reload via :source %

-- Should be on by default in NeoVim - use GUI colors in the terminal
vim.opt.termguicolors = true

local color = require("util/highlight")
local merge = require("util/table").merge
local flatten = require("util/table").flatten

-- Base palette. This defines the fundamental colors of your color scheme.
local colors = {
    -- Start with a decision on what will be your BG and FG.
    -- This defines the "mood" of the theme.
    bg = color.lightnessRamp("#1b1b1c"),
    fg = color.lightnessRamp("#e4e4ef"),

    -- Used to distinguish unknown highlights. Very useful for debugging themes.
    wtf = "#ff00ff",

    -- Structural color: It is used to distinguish things of structural meaning in your code. For example, statements
    -- and keywords.
    structural = "#4a88cc",
    structuralAlt = color.darken("#4a88cc", 1.4), --"#3a6ba1"),

    -- Contentual color: It is used to show things with a content-related meaning. For example: strings and values. They
    -- convey meaning not by context they are used in, but by their value/content.
    contentual = "#85b038",
    contentualAlt = "#a2bf6d",

    -- Functional color: It is used to distinguish things that modify a value for example. Typically, this is used for
    -- operators, functions, and the like.
    functional = "#bf68ed",

    -- Informational color: it is used for things that provide additional information, but are not necessarily required.
    -- Typically used for comments or unobtrusive UI elements.
    informational = "#626262",
    informationalAlt = "#8a8a8a",

    -- Different highlight colors for different severity levels.
    highlight = {

        -- A neutral highlight. The highlight is used to distinguish elements from others without transporting any
        -- meaning. Used for visual selection in text and UI.
        neutral = { fg = "#929295", bg = "#363638" },

        -- ??
        -- informational = {fg= "#4a88cc", bg="#27323e"},

        -- Highlight good things. Added text, modification markers, ...
        good = { fg = "#85b038", bg = "#303329" },

        -- Used to highlight elements of the text or UI that need your attention. This should be well distinguishable
        -- from the other colors used to ensure it sticks out in a bunch of colorful text. Usually used for search
        -- highlights and warnings.
        attention = { fg = "#e79d31", bg = "#3c2e1b" },

        -- A highlight color used to show errors or critical issues. Used whenever something needs attention that
        -- cannot be ignored.
        bad = { fg = "#ed3b44", bg = "#3e262d" },
    },
}

local palette = merge(colors, {

    text = {
        -- The text itself.
        normal = { fg = colors.fg.O, bg = colors.bg.O },

        -- Any additional non-text - This is used for special unprintable chars, the text area after EOL, ...
        nontext = { fg = colors.informational, bold = true },

        -- Passive highlight: the current line (cursor line)
        current = { bg = colors.bg.L2 },

        -- Folded text representation
        folded = { fg = colors.fg.D1, bg = colors.bg.L3, bold = true },

        -- Active highlight: Selected text. Should set a background for selected text. Also used as base style for selected menu items.
        selected = { bg = colors.bg.L4 },

        -- Active highlight: Intensionally highlighted text like search matches or marking matching braces and similar.
        highlight = { colors.highlight.attention, bold = true },

        code = {
            identifiers = { fg = colors.fg.O },
            structural = { fg = colors.structural, bold = true },
            values = { fg = colors.contentual, bold = true },
            strings = { fg = colors.contentualAlt, bold = false },
            functions = { fg = colors.functional, bold = true },
            types = { fg = colors.structural, bold = true },
            preprocs = { fg = colors.fg.O, bold = true },
            comments = { fg = colors.informational, bold = true },
        },
    },

    ui = {
        statusLine = {
            active = {
                fg = colors.fg.D1,
                bg = colors.bg.L3,
            },
            inactive = {
                fg = colors.fg.D2,
                bg = colors.bg.L1,
            },
        },
        commandLine = {
            base = { bold = true },
        },
        gutter = {
            base = { fg = colors.fg.D3, bg = colors.bg.D1 },
            ruler = {
                base = { fg = colors.fg.D4 },
                selected = { fg = colors.fg.O, bold = true },
            },
            folds = {
                bold = true,
            },
        },
        windows = {
            border = { fg = colors.fg.D4 },
        },
    },
})

local highlights = {

    wtf = { bg = palette.wtf },

    -- {{{ Text and in-text UI:

    -- {{{ Basic Text Content
    Normal = { palette.text.normal },
    -- Background without any text. The FG color is used for those chars that do not really exists in the text like
    -- those showbreak chars to show text beyond the edge of the window.
    NonText = { palette.text.nontext },

    -- Unprintable Symbols - tabs and stuff like that. Refer to listchars, the
    -- NOTE: Some plugins use whitespace (i.e. indent line plugins) to color the indent areas.
    Whitespace = { link = "NonText" },
    SpecialKey = { link = "NonText" },
    Special = { link = "NonText" },
    -- }}}

    -- {{{ Search and matches
    IncSearch = { palette.text.highlight },
    Search = { link = "IncSearch" },
    CurSearch = { palette.text.highlight, reverse = true },
    MatchParen = { link = "CurSearch" },
    Substitude = { link = "Search" }, -- the substituted text. I.e. %s/xxx/yyy. The new yyy is highlighted in the text using this.
    -- }}}

    -- {{{ Spelling
    SpellCap = { special = palette.highlight.attention.fg, undercurl = true },
    SpellRare = { special = palette.highlight.neutral.fg, undercurl = true },
    SpellLocal = { special = palette.highlight.attention.fg, undercurl = true },
    SpellBad = { special = palette.highlight.bad.fg, undercurl = true },
    -- }}}

    -- {{{ In-text UI

    -- Folded text
    Folded = { palette.text.folded },

    -- {{{ Cursor
    -- Cursor itself is not required to be set explicitly. It is a flipped fg/bg by default.
    -- Cursor = {},
    -- The line the cursor is right now.
    CursorLine = { palette.text.current },
    -- Activate via 'set cursorcolumn'
    CursorColumn = { link = "CursorLine" },
    -- }}}

    -- {{{ Visual mode
    Visual = { palette.text.selected },
    -- Non-owning selections. This matches in GUIs where the X selection differs from vim's selection.
    VisualNOS = { link = "Visual" },
    -- }}}

    -- {{{ Diff
    -- Used in Diff mode
    DiffChange = { bg = palette.highlight.neutral.bg },
    DiffAdd = { bg = palette.highlight.good.bg },
    DiffDelete = { palette.highlight.bad },
    DiffText = { bg = palette.highlight.neutral.fg, bold = true },

    -- Used inline for diff/patch content
    Changed = { fg = palette.highlight.neutral.fg },
    Added = { fg = palette.highlight.good.fg },
    Removed = { fg = palette.highlight.bad.fg },
    -- }}}

    -- }}}

    -- }}}

    -- {{{ ???
    Error = { link = "wtf" },
    Warning = { link = "wtf" },
    Hint = { link = "wtf" },
    Info = { link = "wtf" },
    -- }}}

    -- {{{ UI

    -- {{{ Gutter
    -- The current line number in the sidebar
    CursorLineNR = { palette.ui.gutter.base, palette.ui.gutter.ruler.base, palette.ui.gutter.ruler.selected },
    -- The LineNr-column for other, not-current lines
    LineNr = { palette.ui.gutter.base, palette.ui.gutter.ruler.base },
    -- The text-width column.
    ColorColumn = { palette.ui.gutter.base },

    -- Column used to show fold UI
    FoldColumn = { palette.ui.gutter.base, palette.ui.gutter.folds },
    -- Used for signs like git-changes/lsp icons/...
    SignColumn = { palette.ui.gutter.base },
    -- }}}

    -- {{{ Status-line
    StatusLine = { palette.ui.statusLine.active },
    -- Status-line for non-current windows
    StatusLineNC = { palette.ui.statusLine.inactive },
    -- }}}

    -- {{{ Command-line
    -- All the message types that appear on the command line
    ErrorMsg = { palette.ui.commandLine.base, fg = palette.highlight.bad.fg },
    WarningMsg = { palette.ui.commandLine.base, fg = palette.highlight.attention.fg },
    MoreMsg = { palette.ui.commandLine.base, fg = palette.highlight.neutral.fg },
    ModeMsg = {},

    -- Whenever a question or prompt is shown on the command line (i.e. "Press enter to continue")
    Question = { palette.ui.commandLine.base },
    -- }}}

    -- {{{ Windows and Menus
    -- The bar when splitting vertically (:vsplit).
    VertSplit = { palette.ui.windows.border },
    -- Separators between window splits.
    WinSeparator = { link = "VertSplit" },
    -- Floating window border
    FloatBorder = { link = "VertSplit" },
    -- The background and foreground of floats. I.e. the whichkey float, lazy, mason, ...
    -- hi! link NormalFloat PMenu
    NormalFloat = {  bg = palette.bg.D2 },
    -- FloatTitle
    -- FloatFooter

    -- {{{ PMenu - Styles used several menus (including completion men)

    -- }}}

    --}}}

    -- {{{ TODO
    -- " NOTE: depending on the completion menu, this might be used automatically, or not. If not, you might want to
    -- " link the highlights of the plugin to these
    --
    -- " Background and foreground
    -- call s:hi("Pmenu",                     s:palette.popupFG,            s:palette.popupBG)
    -- " Selected line
    -- call s:hi("PmenuSel",                  s:palette.selectionFG,        s:palette.selectionBG,        [s:attrs.b])
    --
    -- " The kind text/icon in common complete menus
    -- call s:hi("PmenuKind",                 s:palette.secondary,          s:palette.popupBGD1,          [s:attrs.b])
    -- call s:hi("PmenuKindSel",              s:palette.secondary,          s:palette.selectionBG,        [s:attrs.b])
    --
    -- " The kind text/icon in common complete menus
    -- call s:hi("PmenuDeprecated",           s:palette.fgD2,            s:palette.popupBG,            [s:attrs.s])
    --
    -- " The extra text usually showing "[LSP]", .. in common complete menus
    -- call s:hi("PmenuExtra",                s:palette.fgD3,               s:none,                       [])
    -- call s:hi("PmenuExtraSel",             s:palette.fgD3,               s:palette.selectionBG,        [])
    --
    -- " Scrollbar Thumb
    -- call s:hi("PmenuThumb",                s:none,                       s:palette.popupBGL2)
    -- " Scrollbar BG
    -- call s:hi("PmenuSbar",                 s:none,                       s:palette.popupBGD2)
    --
    --
    --
    -- " Still used?
    -- call s:hi("WildMenu",                  s:palette.wtf,                s:palette.wtf,                [s:attrs.b])
    -- }}}

    -- {{{ LSP Diagnostics
    DiagnosticError = { palette.highlight.bad },
    DiagnosticWarn = { palette.highlight.attention },
    DiagnosticInfo = { palette.highlight.good },
    DiagnosticHint = { palette.highlight.neutral }, -- things like unused vars

    DiagnosticUnnecessary = { link = "Comment" },

    DiagnosticUnderlineError = { underline = true, special = palette.highlight.bad.fg },
    DiagnosticUnderlineWarn = { underline = true, special = palette.highlight.attention.fg },
    DiagnosticUnderlineInfo = { underline = true, special = palette.highlight.good.fg },
    DiagnosticUnderlineHint = { underline = true, special = palette.highlight.neutral.fg },
    -- }}}

    -- {{{ LSP Kind styles }}}

    -- " Style of the suggest popup:
    -- hi! link CocSearch                     Keyword
    -- hi! link CocMenuSel                    PMenuSel
    --
    -- call s:hi("FDCocFloatBorder",          s:palette.popupBGL1)
    -- call s:hi("FDCocFloatSplitter",        s:palette.fgD4)
    --
    -- " Style of thise floating windows (diagnostic error/warnings and so on)
    -- hi! link CocFloatDividingLine          FDCocFloatSplitter
    -- hi! link CocFloating                   PMenu
    --
    -- " This is that [LS] thing in the suggest menu
    -- call s:hi("FDCocPumShortcut",          s:palette.fgD4,               s:palette.popupBGD2,          [])
    -- hi! link CocPumShortcut FDCocPumShortcut
    --
    --
    -- call s:hi("FDCocSymbolCallable",       s:palette.tertiary,           s:palette.popupBGD2,          [s:attrs.b])
    -- hi! link CocSymbolMethod               FDCocSymbolCallable
    -- hi! link CocSymbolFunction             FDCocSymbolCallable
    -- hi! link CocSymbolConstructor          FDCocSymbolCallable
    -- hi! link CocSymbolModule               FDCocSymbolCallable
    --
    -- call s:hi("FDCocSymbolType",           s:palette.highlight,          s:palette.popupBGD2,          [s:attrs.b])
    -- hi! link CocSymbolClass                FDCocSymbolType
    -- hi! link CocSymbolStruct               FDCocSymbolType
    -- hi! link CocSymbolInterface            FDCocSymbolType
    -- hi! link CocSymbolEnum                 FDCocSymbolType
    -- hi! link CocSymbolReference            FDCocSymbolType
    --
    -- call s:hi("FDCocSymbolValue",          s:palette.secondary,          s:palette.popupBGD2,          [s:attrs.b])
    -- hi! link CocSymbolEnumMember           FDCocSymbolValue
    -- hi! link CocSymbolTypeParameter        FDCocSymbolValue
    -- hi! link CocSymbolText                 FDCocSymbolValue
    -- hi! link CocSymbolValue                FDCocSymbolValue
    -- hi! link CocSymbolNumber               FDCocSymbolValue
    -- hi! link CocSymbolBoolean              FDCocSymbolValue
    -- hi! link CocSymbolString               FDCocSymbolValue
    --
    -- call s:hi("FDCocSymbolVariable",       s:palette.fg,                 s:palette.popupBGD2,          [s:attrs.b])
    -- hi! link CocSymbolConstant             FDCocSymbolVariable
    -- hi! link CocSymbolVariable             FDCocSymbolVariable
    -- hi! link CocSymbolField                FDCocSymbolVariable
    -- hi! link CocSymbolProperty             FDCocSymbolVariable
    -- hi! link CocSymbolEvent                FDCocSymbolVariable
    --
    -- call s:hi("FDCocSymbolKeyword",        s:palette.primary,            s:palette.popupBGD2,          [s:attrs.b])
    -- hi! link CocSymbolKeyword              FDCocSymbolKeyword
    -- hi! link CocSymbolOperator             FDCocSymbolKeyword
    --
    --
    -- call s:hi("FDCocSymbolFiles",          s:palette.fg,                 s:palette.popupBGD2,          [s:attrs.b])
    -- hi! link CocSymbolSnippet              FDCocSymbolFiles
    -- hi! link CocSymbolFile                 FDCocSymbolFiles
    -- hi! link CocSymbolFolder               FDCocSymbolFiles
    --
    -- hi! link CocSymbolKey                   WTF
    -- hi! link CocSymbolUnit                  WTF
    -- hi! link CocSymbolNull                  WTF
    -- hi! link CocSymbolPackage               WTF
    -- hi! link CocSymbolObject                WTF
    --
    -- hi! link CocSymbolArray                 WTF
    -- hi! link CocSymbolColor                 WTF
    -- hi! link CocSymbolNamespace             WTF
    -- "
    --

    -- }}}

    -- {{{ Others:

    -- Plugins that show lines for indent levels use these:
    IndentLine = { fg = palette.bg.L1 },
    ScopeLine = { fg = palette.bg.L3 },

    -- }}}

    -- {{{ Syntax

    -- Structural langauge elements like keywords, statements, conditionals, ...
    Keyword = { palette.text.code.structural },
    Statement = { link = "Keyword" },
    Exception = { link = "Keyword" },
    Conditional = { link = "Keyword" },
    Repeat = { link = "Keyword" },
    Structure = { link = "Keyword" },
    StorageClass = { link = "Keyword" },
    Typedef = { link = "Keyword" },
    Label = { link = "Keyword" },
    Tag = { link = "Keyword" },

    -- Things that transform things
    Function = { palette.text.normal },
    Operator = { link = "Keyword" },

    -- Type names like int and such things.
    Type = { palette.text.code.types },

    -- Values
    String = { palette.text.code.strings },
    Number = { palette.text.code.values },
    Float = { link = "Number" },
    Boolean = { link = "Number" },
    Character = { link = "Number" },

    -- Identifiers and named things
    Identifier = { palette.text.code.identifiers },
    Constant = { palette.text.code.identifiers, bold = true }, -- Constants are assumed to be identifiers. They can be values, functions, preproc defines, ....

    -- Comments
    Comment = { palette.text.code.comments },
    SpecialComment = { link = "Keyword" }, -- Things like documentation keywords (@param and the like)
    Todo = { palette.text.highlight }, -- todo/fixme in comments mostly

    -- Preprocessor
    PreProc = { palette.text.code.preprocs },
    Include = { link = "PreProc" },
    Define = { link = "PreProc" },
    Macro = { link = "PreProc" },
    PreCondit = { palette.text.code.preprocs, bg = palette.bg.L3 }, -- conditions like #if, #ifdef, ...

    -- Others

    -- A delimiter char/string is represented like this. This can be the slash in a path, the braces for scopes, ...
    Delimiter = { link = "Comment" },

    -- Chars with a special meaning in constants. Escape chars in strings for example.
    SpecialChar = { link = "Delimiter" },

    -- ?
    Debug = { fg = palette.wtf, bold = true },

    -- Directory names (and other special names in listings)
    Directory = { link = "Keyword" },

    -- Titles. Used in markdown, help, ... or in the command-line when printing long lists (like :set all)
    Title = { palette.text.code.structural },
    -- }}}
}

return {
    palette = palette,

    apply = function()
        for group, hi in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, flatten(hi))
        end
    end,
}
