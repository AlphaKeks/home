local telescope_installed, telescope = pcall(require, "telescope")

if not telescope_installed then
  return
end

local finders = require("telescope.builtin")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions
local filebrowser = telescope.extensions.file_browser.file_browser

telescope.setup({
  defaults = {
    path_display = { "smart" },

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
      sorting_strategy = "ascending",
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

telescope.load_extension("file_browser")
telescope.load_extension("ui-select")

local ivy = function(opts)
  local ret = themes.get_ivy({
    layout_config = {
      height = 0.4,
    },
  })

  for key, value in pairs(opts or {}) do
    ret[key] = value
  end

  return ret
end

local dropdown = function(opts)
  local ret = themes.get_dropdown({
    layout_config = {
      height = 0.9,
      width = 0.9,
    },
  })

  for key, value in pairs(opts or {}) do
    ret[key] = value
  end

  return ret
end

nn("<C-f>", function()
  finders.current_buffer_fuzzy_find(ivy())
end)

nn("<Leader>ff", function()
  finders.find_files(ivy({
    hidden = true,
    follow = true,
  }))
end)

nn("<Leader>fh", function()
  finders.help_tags(ivy())
end)

nn("<Leader>fl", function()
  finders.live_grep(ivy())
end)

nn("<Leader>fd", function()
  finders.diagnostics(ivy())
end)

nn("<Leader>fr", function()
  finders.lsp_references(ivy())
end)

nn("<Leader>fs", function()
  finders.lsp_workspace_symbols(ivy())
end)

nn("<Leader>fi", function()
  finders.lsp_implementations(ivy())
end)

nn("<Leader>e", function()
  filebrowser(dropdown({
    previewer = false,
    hidden = true,
    cwd = vim.fn.expand("%:p:h"),
    initial_mode = "normal",
  }))
end)
