-- Name:          dawn.nvim
-- Author:        AlphaKeks <alphakeks@dawn.sh>
-- Maintainer:    AlphaKeks <alphakeks@dawn.sh>
-- License:       MIT
-- Color palette: https://github.com/catppuccin/nvim

vim.cmd([[
  set background=dark
  highlight clear
  syntax reset
  let g:colors_name="dawn"
]])

Dawn = {
  rosewater = "#F5E0DC",
  flamingo  = "#F2CDCD",
  pink      = "#F5C2E7",
  mauve     = "#CBA6F7",
  red       = "#F38BA8",
  maroon    = "#EBA0AC",
  peach     = "#FAB387",
  yellow    = "#F9E2AF",
  green     = "#A6E3A1",
  teal      = "#94E2D5",
  sky       = "#89DCEB",
  sapphire  = "#74C7EC",
  blue      = "#89B4FA",
  lavender  = "#B4BEFE",

  text      = "#CDD6F4",
  subtext1  = "#BAC2DE",
  subtext0  = "#A6ADC8",
  overlay2  = "#9399B2",
  overlay1  = "#7F849C",
  overlay0  = "#6C7086",
  surface2  = "#585B70",
  surface1  = "#45475A",
  surface0  = "#313244",

  base      = "#1E1E2E",
  mantle    = "#181825",
  crust     = "#11111B",

  none      = "NONE",
  slate     = "#3C5E7F",
  poggers   = "#7480C2",
}

local function hi(group, opts)
  opts = opts or {}
  vim.api.nvim_set_hl(0, group, opts)
end

--[[-------------------------------------------EDITOR-------------------------------------------]]--

hi("ColorColumn", {
  bg = Dawn.surface0,
})

hi("Conceal", {
  bg = Dawn.none,
  fg = Dawn.poggers,
  bold = true,
})

hi("Cursor", {
  fg = Dawn.base,
  bg = Dawn.yellow,
})

hi("lCursor", {
  link = "Cursor",
})

hi("CursorIM", {
  link = "Cursor",
})

hi("CursorColumn", {
  link = "ColorColumn",
})

hi("CursorLine", {
  link = "ColorColumn",
})

hi("Directory")

hi("EndOfBuffer", {
  fg = Dawn.poggers,
})

hi("ErrorMsg", {
  fg = Dawn.red,
  bold = true,
})

hi("VertSplit", {
  fg = Dawn.text,
  bg = Dawn.none,
})

hi("Folded", {
  fg = Dawn.slate,
  bg = Dawn.none,
  bold = true,
})

hi("FoldColumn", {
  bg = Dawn.transparent and Dawn.none or Dawn.base,
})

hi("SignColumn", {
  bg = Dawn.transparent and Dawn.none or Dawn.base,
})

hi("Substitute", {
  fg = Dawn.text,
  bg = Dawn.red,
})

hi("LineNr", {
  fg = Dawn.overlay1,
  bg = Dawn.none,
})

hi("CursorLineNr", {
  fg = Dawn.yellow,
  bg = Dawn.none,
  bold = true,
})

hi("MatchParen", {
  fg = Dawn.peach,
  bg = Dawn.surface1,
})

hi("ModeMsg", {
  fg = Dawn.text,
  bold = true,
})

hi("MsgSeparator")

hi("MoreMsg", {
  fg = Dawn.subtext0,
  bold = true,
  italic = true,
})

hi("NonText", {
  fg = Dawn.subtext0,
})

hi("Normal", {
  fg = Dawn.text,
  bg = Dawn.transparent and Dawn.none or Dawn.base,
})

hi("NormalNC", {
  link = "Normal",
})

hi("NormalFloat", {
  fg = Dawn.text,
  bg = Dawn.none,
})

hi("FloatBorder", {
  fg = Dawn.lavender,
  bg = Dawn.transparent and Dawn.none or Dawn.base,
})

hi("FloatTitle", {
  fg = Dawn.subtext0,
})

hi("Pmenu", {
  fg = Dawn.surface2,
  bg = Dawn.mantle,
})

hi("PmenuSel", {
  fg = Dawn.sky,
  bg = Dawn.surface2,
})

hi("PmenuSbar", {
  bg = Dawn.surface0,
})

hi("PmenuThumb", {
  bg = Dawn.overlay0,
})

hi("Question", {
  fg = Dawn.green,
})

hi("QuickFixLine", {
  link = "Visual",
})

hi("Search", {
  fg = Dawn.crust,
  bg = Dawn.yellow,
})

hi("IncSearch", {
  fg = Dawn.crust,
  bg = Dawn.poggers,
})

hi("CurSearch")

hi("SpecialKey", {
  fg = Dawn.mauve,
  italic = true,
})

hi("SpellBad")

hi("SpellCap")

hi("SpellLocal")

hi("SpellRare")

hi("StatusLine")

hi("StatusLineNC")

hi("TabLine", {
  fg = Dawn.subtext0,
  bg = Dawn.crust,
})

hi("TabLineFill", {
  fg = Dawn.none,
  bg = Dawn.none,
})

hi("TabLineSel", {
  fg = Dawn.poggers,
  bg = Dawn.mantle,
  bold = true,
})

hi("Title", {
  fg = Dawn.poggers,
})

hi("Visual", {
  bg = Dawn.surface2,
})

hi("VisualNOS")

hi("WarningMsg", {
  fg = Dawn.yellow,
  italic = true,
})

hi("Whitespace", {
  fg = Dawn.surface2,
})

hi("WildMenu", {
  fg = Dawn.sky,
  bg = Dawn.surface2,
})

hi("WinBar", {
  fg = Dawn.pink,
  italic = true,
})

hi("DiagnosticOk", {
  fg = Dawn.green,
  bg = Dawn.none,
})

hi("DiagnosticHint", {
  fg = Dawn.teal,
  bg = Dawn.none,
})

hi("DiagnosticInfo", {
  fg = Dawn.blue,
  bg = Dawn.none,
})

hi("DiagnosticWarn", {
  fg = Dawn.yellow,
  bg = Dawn.none,
})

hi("DiagnosticError", {
  fg = Dawn.red,
  bg = Dawn.none,
})

hi("DiagnosticDeprecated", {
  link = "Comment",
})

hi("DiagnosticUnnecessary", {
  link = "Comment",
})

hi("DiagnosticSignOk", {
  link = "DiagnosticOk",
})

hi("DiagnosticSignHint", {
  link = "DiagnosticHint",
})

hi("DiagnosticSignInfo", {
  link = "DiagnosticInfo",
})

hi("DiagnosticSignWarn", {
  link = "DiagnosticWarn",
})

hi("DiagnosticSignError", {
  link = "DiagnosticError",
})

hi("DiagnosticFloatingOk", {
  link = "DiagnosticOk",
})

hi("DiagnosticFloatingHint", {
  link = "DiagnosticHint",
})

hi("DiagnosticFloatingInfo", {
  link = "DiagnosticInfo",
})

hi("DiagnosticFloatingWarn", {
  link = "DiagnosticWarn",
})

hi("DiagnosticFloatingError", {
  link = "DiagnosticError",
})

hi("DiagnosticUnderlineOk", {
  link = "DiagnosticOk",
})

hi("DiagnosticUnderlineHint", {
  link = "DiagnosticHint",
})

hi("DiagnosticUnderlineInfo", {
  link = "DiagnosticInfo",
})

hi("DiagnosticUnderlineWarn", {
  link = "DiagnosticWarn",
})

hi("DiagnosticUnderlineError", {
  link = "DiagnosticError",
})

hi("DiagnosticVirtualTextOk", {
  link = "DiagnosticOk",
})

hi("DiagnosticVirtualTextHint", {
  link = "DiagnosticHint",
})

hi("DiagnosticVirtualTextInfo", {
  link = "DiagnosticInfo",
})

hi("DiagnosticVirtualTextWarn", {
  link = "DiagnosticWarn",
})

hi("DiagnosticVirtualTextError", {
  link = "DiagnosticError",
})

--[[-------------------------------------------EDITOR-------------------------------------------]]--

--[[-------------------------------------------SYNTAX-------------------------------------------]]--

hi("Comment", {
  fg = Dawn.slate,
  bg = Dawn.none,
  italic = true,
})

hi("SpecialComment", {
  link = "Special",
})

hi("Constant", {
  fg = Dawn.red,
  bold = true,
})

hi("String", {
  fg = Dawn.green,
})

hi("Character", {
  fg = Dawn.teal,
})

hi("Number", {
  fg = Dawn.red,
})

hi("Float", {
  link = "Number",
})

hi("Boolean", {
  fg = Dawn.red,
})

hi("Identifier", {
  fg = Dawn.lavender,
})

hi("Function", {
  fg = Dawn.blue,
  italic = true,
})

hi("Statement", {
  link = "Keyword",
})

hi("Conditional", {
  fg = Dawn.mauve,
})

hi("Repeat", {
  fg = Dawn.mauve,
})

hi("Label", {
  fg = Dawn.sapphire,
})

hi("Operator", {
  fg = Dawn.yellow,
})

hi("Keyword", {
  fg = Dawn.mauve,
})

hi("PreProc", {
  fg = Dawn.text,
  bold = true,
})

hi("Include", {
  fg = Dawn.mauve,
})

hi("Define", {
  link = "PreProc",
})

hi("Macro", {
  fg = Dawn.mauve,
  italic = true,
})

hi("PreCondit", {
  link = "PreProc",
})

hi("StorageClass", {
  fg = Dawn.yellow,
  bold = true,
})

hi("Structure", {
  link = "Type",
})

hi("Special", {
  fg = Dawn.mauve,
  italic = true,
})

hi("Type", {
  fg = Dawn.poggers,
  bold = true,
  italic = true,
})

hi("Typedef", {
  link = "Type",
})

hi("SpecialChar", {
  fg = Dawn.sky,
  italic = true,
})

hi("Tag", {
  link = "Special",
})

hi("Delimiter", {
  fg = Dawn.overlay2,
})

hi("Variable", {
  fg = Dawn.text,
})

hi("Underlined", {
  italic = true,
  underline = true,
  undercurl = true,
})

hi("Bold", {
  bold = true,
})

hi("Italic", {
  italic = true,
})

hi("Error", {
  fg = Dawn.red,
  bold = true,
})

hi("Todo", {
  fg = Dawn.yellow,
  bold = true,
})

hi("qfLineNr", {
  link = "LineNr",
})

hi("qfFileName", {
  fg = Dawn.blue,
  bold = true,
})

hi("debugPC")

hi("debugBreakpoint", {
  fg = Dawn.mauve,
})

hi("DiffAdd", {
  fg = Dawn.green,
})

hi("DiffChange", {
  fg = Dawn.yellow,
})

hi("DiffDelete", {
  fg = Dawn.red,
})

--[[-------------------------------------------SYNTAX-------------------------------------------]]--

--[[--------------------------------------------RUST--------------------------------------------]]--

hi("rustFoldBraces", {
  link = "Delimiter",
})

hi("rustBoxPlacementBalance", {
  link = "Delimiter",
})

hi("@storageclass.lifetime.rust", {
  fg = Dawn.sapphire,
})

hi("@lsp.typemod.builtinAttribute.attribute.rust", {
  fg = Dawn.red,
})

hi("@lsp.type.formatSpecifier.rust", {
  link = "@punctuation.bracket",
})

hi("@lsp.type.variable.rust", {
  link = "@variable",
})

hi("@lsp.typemod.operator.controlFlow.rust", {
  fg = Dawn.mauve,
  bold = true,
})

hi("@lsp.typemod.keyword.injected.rust", {
  link = "@keyword",
})

hi("@lsp.typemod.operator.injected.rust", {
  link = "@operator",
})

hi("@lsp.typemod.number.injected.rust", {
  link = "@number",
})

hi("@lsp.typemod.generic.injected.rust", {
  link = "@punctuation",
})

hi("@lsp.typemod.string.injected.rust", {
  link = "@string",
})

hi("@lsp.typemod.builtinType.injected.rust", {
  link = "@type.builtin",
})

hi("@lsp.typemod.boolean.injected.rust", {
  link = "@boolean",
})

hi("@lsp.typemod.lifetime.injected.rust", {
  link = "rustLifetime",
})

hi("@lsp.type.selfKeyword.rust", {
  fg = Dawn.red,
  bold = true,
})

hi("@lsp.typemod.namespace.attribute.rust", {
  fg = Dawn.peach,
  bold = true,
})

hi("@lsp.type.number.rust", {
  link = "@number",
})

hi("@lsp.typemod.character.injected.rust", {
  link = "@character",
})

hi("@lsp.typemod.punctuation.injected.rust", {
  link = "@punctuation",
})

hi("@lsp.typemod.keyword.crateRoot.rust", {
  fg = Dawn.pink,
  bold = true,
})

--[[--------------------------------------------RUST--------------------------------------------]]--

--[[--------------------------------------------LUA --------------------------------------------]]--

hi("luaParen", {
  link = "Delimiter",
})

hi("luaTableBlock", {
  fg = Dawn.lavender,
})

--[[--------------------------------------------LUA --------------------------------------------]]--

--[[-----------------------------------------TREESITTER-----------------------------------------]]--

hi("@boolean", {
  link = "Boolean",
})

hi("@character", {
  link = "Character",
})

hi("@character.special", {
  link = "SpecialChar",
})

hi("@comment", {
  link = "Comment",
})

hi("@conceal", {
  link = "Conceal",
})

hi("@conditional", {
  link = "Conditional",
})

hi("@constant", {
  link = "Constant",
})

hi("@constant.builtin", {
  link = "Constant",
})

hi("@constant.macro", {
  link = "Macro",
})

hi("@constructor", {
  link = "@punctuation.bracket",
})

hi("@debug")

hi("@define", {
  link = "Define",
})

hi("@exception", {
  fg = Dawn.red,
  italic = true,
})

hi("@field", {
  fg = Dawn.lavender,
})

hi("@float", {
  link = "Float",
})

hi("@function", {
  link = "Function",
})

hi("@function.builtin", {
  link = "Function",
})

hi("@function.macro", {
  link = "Macro",
})

hi("@include", {
  link = "Include",
})

hi("@keyword", {
  link = "Keyword",
})

hi("@label", {
  link = "Label",
})

hi("@macro", {
  link = "Macro",
})

hi("@method", {
  link = "Function",
})

hi("@namespace", {
  fg = Dawn.blue,
})

hi("@number", {
  link = "Number",
})

hi("@operator", {
  link = "Operator",
})

hi("@parameter", {
  fg = Dawn.maroon,
})

hi("@preproc", {
  link = "PreProc",
})

hi("@property", {
  link = "@field",
})

hi("@punctuation", {
  fg = Dawn.overlay2,
})

hi("@repeat", {
  link = "Repeat",
})

hi("@storageclass", {
  link = "StorageClass",
})

hi("@string", {
  link = "String",
})

hi("@string.escape", {
  fg = Dawn.pink,
})

hi("@string.special", {
  link = "Special",
})

hi("@tag", {
  link = "Tag",
})

hi("@variable", {
  link = "Variable",
})

hi("@text.literal", {
  fg = Dawn.blue,
  bold = true,
})

hi("@text.reference", {
  link = "@text.literal",
})

hi("@text.title", {
  link = "@text.literal",
})

hi("@text.todo", {
  link = "Todo",
})

hi("@text.underline", {
  link = "Underlined",
})

hi("@text.uri", {
  link = "@text.underline",
})

hi("@type", {
  link = "Type",
})

hi("@type.builtin", {
  fg = Dawn.poggers,
})

hi("@type.definition", {
  link = "Type",
})

--[[-----------------------------------------TREESITTER-----------------------------------------]]--

--[[--------------------------------------------LSP---------------------------------------------]]--

hi("@lsp.type.class", {
  link = "@type",
})

hi("@lsp.type.comment", {
  link = "@comment",
})

hi("@lsp.type.decorator", {
  fg = Dawn.rosewater,
})

hi("@lsp.type.enum", {
  link = "@type",
})

hi("@lsp.type.enumMember", {
  fg = Dawn.peach,
  bold = true,
})

hi("@lsp.type.function", {
  link = "@function",
})

hi("@lsp.type.interface", {
  fg = Dawn.flamingo,
  bold = true,
})

hi("@lsp.type.macro", {
  link = "@macro",
})

hi("@lsp.type.method", {
  link = "@function",
})

hi("@lsp.type.namespace", {
  link = "@namespace",
})

hi("@lsp.type.parameter", {
  fg = Dawn.red,
})

hi("@lsp.type.property", {
  link = "@field",
})

hi("@lsp.type.struct", {
  link = "@type",
})

hi("@lsp.type.type", {
  link = "@type",
})

hi("@lsp.type.typeParameter", {
  link = "@type",
})

hi("@lsp.type.variable", {
  link = "@variable",
})

--[[--------------------------------------------LSP---------------------------------------------]]--

--[[------------------------------------------TELESCOPE-----------------------------------------]]--

hi("TelescopeSelection", {
  fg = Dawn.red,
  bg = Dawn.none,
})

hi("TelescopeSelectionCaret", {
  fg = Dawn.poggers,
  bg = Dawn.none,
})

--[[------------------------------------------TELESCOPE-----------------------------------------]]--
