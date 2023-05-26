require("globals")
require("plugins")

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 69 })
  end,
})
