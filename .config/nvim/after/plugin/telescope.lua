local telescope_installed, telescope = pcall(require, "telescope")

if not telescope_installed then
  return
end

local finders = require("telescope.builtin")
local themes = require("telescope.themes")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "smart" },
  },
})

local ivy = function(opts)
  local ret = themes.get_ivy({
    layout_config = {
      height = 0.4,
    },
  })

  if opts then
    vim.tbl_deep_extend("keep", ret, opts)
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
