local catppuccin_installed, catppuccin = pcall(require, "catppuccin")

if not catppuccin_installed then
  vim.notify("catppuccin is not installed.")
  return
end

local palette = require("catppuccin.palettes").get_palette("mocha")

Colors = {
  none = "NONE",
  slate = "#3C5E7F",
  poggers = "#7480C2",
}

vim.tbl_extend("keep", Colors, palette)

catppuccin.setup({
  flavour = "mocha",
  transparent_background = true,
  no_italic = true,

  integrations = {
    cmp = true,
    gitsigns = true,
    harpoon = true,
    mason = true,
    neogit = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    native_lsp = {
      enabled = true,
    },
  },

  custom_highlights = {
    Comment = { fg = Colors.slate },
    Constant = { fg = Colors.red },
    String = { fg = Colors.lavender },
    Number = { fg = Colors.red },
    Float = { link = "Numer" },
    Boolean = { link = "Number" },
    Identifier = { fg = Colors.lavender },
    Operator = { fg = Colors.yellow },
    StorageClass = { fg = Colors.sapphire },
    Structure = { fg = Colors.poggers },
    Type = { fg = Colors.poggers, bold = true },
    Typedef = { fg = Colors.poggers, bold = true },
    Delimiter = { fg = Colors.sapphire },
    ColorColumn = { bg = Colors.surface0 },
    CursorLine = { link = "ColorColumn" },
    CursorLineNr = { fg = Colors.yellow },
    EndOfBuffer = { fg = Colors.mauve },
    Search = { fg = Colors.mantle, bg = Colors.yellow },
    CurSearch = { fg = "#FFFFFF", bg = Colors.red },
    IncSearch = { fg = Colors.text, bg = Colors.poggers },
    MatchParen = { fg = Colors.lavender },
    Whitespace = { fg = Colors.surface2 },
    WinSeparator = { fg = Colors.none, bg = Colors.none },
    NormalFloat = { bg = Colors.none },
    FloatShadow = { bg = Colors.none },
    FloatShadowThrough = { bg = Colors.none },
    DiagnosticHint = { bg = Colors.none },
    DiagnosticInfo = { bg = Colors.none },
    DiagnosticWarn = { bg = Colors.none },
    DiagnosticError = { bg = Colors.none },
    DiagnosticVirtualTextHint = { bg = Colors.none },
    DiagnosticVirtualTextInfo = { bg = Colors.none },
    DiagnosticVirtualTextWarn = { bg = Colors.none },
    DiagnosticVirtualTextError = { bg = Colors.none },
    TreesitterContext = { bg = Colors.none },
  },
})

vim.cmd.colorscheme("catppuccin")
