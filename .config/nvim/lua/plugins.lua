local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git", "clone", "--branch=stable",
    "https://github.com/folke/lazy.nvim",
    lazy_path,
  })

  vim.notify("Installed lazy.nvim")
end

vim.opt.rtp:prepend(lazy_path)

local lazy_installed, lazy = pcall(require, "lazy")

if not lazy_installed then
  vim.notify("lazy.nvim is not installed.")
  vim.notify("Plugins will be disabled.")
  return
end

local lazy_opts = {
  defaults = {
    lazy = false,
  },
  spec = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    "williamboman/mason.nvim",
    "lvimuser/lsp-inlayhints.nvim",
  },
  concurrency = 69,
  install = {
    missing = true,
    colorscheme = { "catppuccin", "habamax", "quiet" },
  },
  ui = {
    wrap = true,
    border = "single",
    browser = "firefox",
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = false,
    },
  },
}

lazy.setup(lazy_opts)
