local comment_installed, comment = pcall(require, "Comment")

if not comment_installed then
  vim.notify("Comment.nvim is not installed.")
  return
end

comment.setup({
  mappings = {
    basic = false,
    extra = false,
  },
})

vim.cmd([[

nn <Leader>c <Plug>(comment_toggle_linewise_current)
vn <Leader>c <Plug>(comment_toggle_blockwise_visual)
xn <Leader>c <Plug>(comment_toggle_linewise_visual)

]])
