local neogit_installed, neogit = pcall(require, "neogit")
local gitsigns_installed, gitsigns = pcall(require, "gitsigns")

if not neogit_installed then
  vim.notify("neogit is not installed.")
  return
end

if not gitsigns_installed then
  vim.notify("gitsigns is not installed.")
  return
end

neogit.setup({
  disable_context_highlighting = true,

  commit_popup = {
    kind = "vsplit",
  },

  popup = {
    kind = "split",
  },

  integrations = {
    diffview = true,
  },
})

gitsigns.setup()

vim.keymap.set("n", "<Leader>gb", gitsigns.blame_line)
vim.keymap.set("n", "<Leader>gB", function()
  gitsigns.blame_line({ full = true })
end)

vim.keymap.set("n", "<Leader>gs", neogit.open)
