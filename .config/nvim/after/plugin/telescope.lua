local telescope_installed, telescope = pcall(require, "telescope")

if not telescope_installed then
  vim.notify("Telescope is not installed.")
  return
end

local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      ["i"] = {
        ["<ESC>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },

  extensions = {
    ["file_browser"] = {
      hijack_netrw = true,
      hidden = true,
      previewer = true,
      initial_mode = "normal",
      mappings = {
        ["n"] = {
          ["a"] = fb_actions.create,
          ["d"] = fb_actions.remove,
          ["r"] = fb_actions.rename
        },
        ["i"] = {
          ["<C-a>"] = fb_actions.create,
          ["<C-d>"] = fb_actions.remove,
          ["<C-r>"] = fb_actions.rename,
          ["<ESC>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous
        }
      },
    },

    ["ui-select"] = {
      themes.get_cursor(),
    },
  },
})

telescope.load_extension("ui-select")
telescope.load_extension("file_browser")

local default_finder = themes.get_ivy({
  layout_config = {
    height = 0.4,
  },
})

vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader>fh", builtin.help_tags)

vim.keymap.set("n", "<Leader>ff", function()
  builtin.find_files(themes.get_ivy({
    hidden = true,
    follow = true,
    layout_config = {
      height = 0.4,
    },
  }))
end)

vim.keymap.set("n", "<Leader>fg", function()
  builtin.git_files(default_finder)
end)


vim.keymap.set("n", "<Leader>fh", function()
  builtin.help_tags(default_finder)
end)

vim.keymap.set("n", "<Leader>df", function()
  builtin.git_files(themes.get_ivy({
    cwd = os.getenv("HOME") .. "/.dotfiles",
    hidden = true,
    follow = true,
    layout_config = {
      height = 0.4,
    },
  }))
end)

vim.keymap.set("n", "<Leader>fl", function()
  builtin.live_grep(themes.get_ivy({
    hidden = true,
    follow = true,

    layout_config = {
      height = 0.4,
    },

    glob_patterns = {
      "!node_modules/*",
      "!target/*",
    },
  }))
end)

vim.keymap.set("n", "<Leader>fd", function()
  builtin.diagnostics(default_finder)
end)

vim.keymap.set("n", "<Leader>fs", function()
  builtin.lsp_workspace_symbols(default_finder)
end)

vim.keymap.set("n", "<Leader>fr", function()
  builtin.lsp_references(default_finder)
end)

vim.keymap.set("n", "<Leader>e", function()
  telescope.extensions.file_browser.file_browser(themes.get_dropdown({
    previewer = false,
    hidden = true,
    cwd = vim.fn.expand("%:p:h"),
    initial_mode = "normal",
    layout_config = {
      height = 0.9,
      width = 0.9,
    },
  }))
end)

local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

vim.keymap.set("n", "<Leader>j", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<Leader>a", harpoon_mark.add_file)

vim.keymap.set("n", "<F1>", function()
  harpoon_ui.nav_file(1)
end)

vim.keymap.set("n", "<F2>", function()
  harpoon_ui.nav_file(2)
end)

vim.keymap.set("n", "<F3>", function()
  harpoon_ui.nav_file(3)
end)

vim.keymap.set("n", "<F4>", function()
  harpoon_ui.nav_file(4)
end)
