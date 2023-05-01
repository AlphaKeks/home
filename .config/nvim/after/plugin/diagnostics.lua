vim.diagnostic.config({
  underline = false,
  severity_sort = true,

  virtual_text = {
    source = false,
    prefix = "",
    severity = vim.diagnostic.severity.ERROR,
  },

  float = {
    focusable = true,
    source = "always",
    prefix = "• ",
    border = "single",
  },
})
