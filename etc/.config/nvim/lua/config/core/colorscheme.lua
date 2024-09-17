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

local colors2 = {}

-- Base palette. This defines the fundamental colors of your color scheme.
local colors = {
    -- Start with a decision on what will be your BG and FG.
    -- This defines the "mood" of the theme.
    bg = color.lightnessRamp("#1a1a1c"),
    fg = color.lightnessRamp("#c9c9cd"),

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

    -- Different highlight colors for different severity levels.
    highlight = {

        -- A neutral highlight. The highlight is used to distinguish elements from others without transporting any
        -- meaning. Used for visual selection in text and UI.
        neutral = { fg = "#929295", bg = "#363638" },

        -- ??
        informational = { fg = "#4a88cc", bg = "#27323e" },

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
        folded = { fg = colors.fg.D1, bg = colors.bg.L2, bold = true },

        -- Active highlight: Selected text. Should set a background for selected text. Also used as base style for selected menu items.
        selected = { bg = colors.bg.L4 },

        -- Active highlight: Intensionally highlighted text like search matches or marking matching braces and similar.
        highlight = { colors.highlight.attention, bold = true },

        code = {
            identifiers = { fg = colors.fg.O },
            structural = { fg = colors.structural, bold = true },
            values = { fg = colors.contentual, bold = true },
            strings = { fg = colors.contentualAlt, bold = false },
            functions = { fg = colors.fg.O, bold = false },
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
            base = { -- bg = colors.bg.D1,
                bold = true,
            },
        },
        gutter = {
            base = { bg = colors.bg.D1 },
            ruler = {
                base = { fg = colors.fg.D4 },
                selected = { fg = colors.fg.O, bold = true },
            },
            folds = {
                fg = colors.fg.D3,
                bold = true,
            },
        },
        window = {
            border = { fg = colors.bg.L4, bg = colors.bg.O },
            normal = { fg = colors.fg.O, bg = colors.bg.D2 },
        },
        menu = {
            border = { fg = colors.fg.D4 },
            normal = { fg = colors.fg.D1, bg = colors.bg.L2 },
            selected = { bg = colors.bg.L4 },
            matched = {
                bold = true,
                -- fg = colors.highlight.attention.fg,
                fg = colors.fg.O,
                --bg = colors.bg.L3
            },
            kind = { fg = colors.fg.O, bg = colors.bg.D1, bold = true },
        },
        sidebar = {
            normal = { fg = colors.fg.O, bg = colors.bg.D1 },
            border = { fg = colors.bg.L2, bg = colors.bg.D1 },
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

    -- Used in the gutter to indicate changes. This is a slightly less bright version of changed/added/removed
    ChangedSign = { fg = color.darken(palette.highlight.neutral.fg, 1.43), bg = palette.ui.gutter.base.bg },
    AddedSign = { fg = color.darken(palette.highlight.good.fg, 1.33), bg = palette.ui.gutter.base.bg },
    RemovedSign = { fg = color.darken(palette.highlight.bad.fg, 1.33), bg = palette.ui.gutter.base.bg },
    -- }}}

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
    Function = { palette.text.code.functions },
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

    MsgArea = { palette.ui.commandLine.base },

    -- Whenever a question or prompt is shown on the command line (i.e. "Press enter to continue")
    Question = { palette.ui.commandLine.base },
    -- }}}

    -- {{{ Windows and Menus
    -- The bar when splitting vertically (:vsplit).
    VertSplit = { palette.ui.window.border },
    -- Separators between window splits.
    WinSeparator = { link = "VertSplit" },

    -- {{{ Floats
    -- Floating window border
    FloatBorder = { link = "VertSplit" },
    FloatTitle = { link = "Title" },
    FloatFooter = { link = "FloatTitle" },
    NormalFloat = { palette.ui.window.normal },
    -- }}}

    -- {{{ PMenu - Styles used several menus (including completion men)
    Pmenu = { palette.ui.menu.normal },
    PmenuSel = { palette.ui.menu.selected },

    PmenuMatch = { palette.ui.menu.matched },
    PmenuMatchSel = { link = "PmenuMatch" },

    PmenuKind = { palette.ui.menu.kind },
    PmenuKindSel = { fg = palette.wtf },
    -- PmenuExtra = { fg = "red" },
    -- PmenuExtraSel = { fg = "red" },

    PmenuSbar = { link = "Pmenu" },
    PmenuThumb = { bg = palette.ui.window.border.fg },
    -- }}}

    -- {{{ Quickfix

    QuickFixLine = { link = "Visual" },

    -- }}}

    -- {{{ Base definition for side-bars/windows. Filebrowser, Code sumbols and others

    SidebarNormal = { palette.ui.sidebar.normal },
    SidebarVertSplit = { palette.ui.sidebar.border },

    -- }}}

    --}}}

    -- {{{ TODO
    --
    --WinBar
    --WinBarNC

    WinBar = { fg = palette.wtf },
    WinBarNC = { fg = palette.wtf },
    SnippetTabstop = { fg = palette.wtf },
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

    LspItemKind = { link = "PmenuKind" },

    LspItemKindFunction = { palette.ui.menu.kind, palette.text.code.functions },
    LspItemKindType = { palette.ui.menu.kind, palette.text.code.types },
    LspItemKindValue = { palette.ui.menu.kind, palette.text.code.values },
    LspItemKindString = { palette.ui.menu.kind, palette.text.code.strings },
    LspItemKindKeyword = { palette.ui.menu.kind, palette.text.code.structural },
    LspItemKindFiles = { palette.ui.menu.kind, palette.text.code.identifiers },

    -- }}}

    -- {{{ Others:

    -- Plugins that show lines for indent levels use these:
    IndentLine = { fg = palette.bg.L1 },
    ScopeLine = { fg = palette.bg.L3 },

    -- }}}
}

return {
    palette = palette,

    apply = function()
        for group, hi in pairs(highlights) do
            color.set(group, hi)
        end
    end,
}
