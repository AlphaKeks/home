local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git", "clone", "--branch=stable",
    "https://github.com/folke/lazy.nvim",
    lazy_path,
  })

  vim.notify("Installed Lazy.")
end

vim.opt.rtp:prepend(lazy_path)
