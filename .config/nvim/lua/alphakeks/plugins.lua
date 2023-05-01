local lazy_installed, lazy = pcall(require, "lazy")

if not lazy_installed then
  vim.notify("Lazy is not installed.")
  return
end

local plugins = {
  { "catppuccin/nvim", name = "catppuccin" },
  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "numToStr/Comment.nvim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
  },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "simrat39/rust-tools.nvim" },
  {
    "sourcegraph/sg.nvim",
    build = "cargo build --workspace",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
          { "nvim-tree/nvim-web-devicons" },
        },
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "ThePrimeagen/harpoon" },
    },
  },
  {
    "TimUntersberger/neogit",
    dependencies = {
      { "lewis6991/gitsigns.nvim" },
      { "sindrets/diffview.nvim" },
    },
  },
}

local opts = {
  ui = {
    border = "single",
    browser = "firefox",
  },

  performance = {
    cache = {
      enabled = true,
    },

    reset_packpath = true,

    rtp = {
      reset = true,
      disabled_plugins = {
        "netrwPlugin",
      },
    },
  },
}

lazy.setup(plugins, opts)
