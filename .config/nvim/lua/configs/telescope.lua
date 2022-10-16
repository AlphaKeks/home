local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
	defaults = {
		prompt_prefix = "» ",
		selection_caret = "> ",
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close
			}
		}
	},

	extensions = {
		file_browser = {
			theme = "dropdown",
			hijack_netrw = true,
			hidden = true,
			previewer = false,
			initial_mode = "normal",
			mappings = {
				n = {
					a = fb_actions.create,
					d = fb_actions.remove,
					r = fb_actions.rename
				},
				i = {
					["<C-a"] = fb_actions.create,
					["<C-d"] = fb_actions.remove,
					["<C-r"] = fb_actions.rename,
					["<esc>"] = actions.close
				}
			}
		}
	}
}

telescope.load_extension("file_browser")
telescope.load_extension("harpoon")

local map = vim.keymap.set
local def = { silent = true }

local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local fb = telescope.extensions.file_browser

local cwd = vim.fn.expand("%:p:h")

map("n", "<leader>ff", function()
	builtin.find_files(themes.get_dropdown {
		prompt_title = cwd,
		previewer = false,
		hidden = true,

		layout_config = {
			width = 0.45,
			height = 0.45
		}
	})
end, def)

map("n", "<leader>fl", function()
	builtin.live_grep(themes.get_dropdown {
		prompt_title = "~ live grep ~",
		previewer = false,
		hidden = true,

		layout_config = {
			width = 0.4,
			height = 0.4,
			anchor = "NE"
		}
	})
end, def)

map("n", "<leader><tab>", function()
	builtin.buffers(themes.get_dropdown {
		prompt_title = "~ buffers ~",
		previewer = false,
		initial_mode = "normal",

		layout_config = {
			width = 0.65,
			height = 0.25,
			anchor = "N",
			prompt_position = "bottom"
		}
	})
end, def)

map("n", "<leader>fg", function()
	builtin.git_commits(themes.get_dropdown {
		prompt_title = "~ commits ~",
		initial_mode = "normal",

		layout_config = {
			width = 0.75,
			height = 0.9,
		}
	})
end, def)

map("n", "<leader>fr", function()
	builtin.lsp_references(themes.get_ivy {
		prompt_title = "LSP references",
		
		layout_config = {
			height = 0.35
		}
	})
end, def)

map("n", "<leader>df", function()
	fb.file_browser(themes.get_dropdown {
		prompt_title = "~/.dotfiles",
		previewer = false,
		hidden = true,
		cwd = "~/.dotfiles",
		initial_mode = "normal",

		layout_config = {
			width = 0.45,
			height = 0.45
		}
	})
end, def)

map("n", "<leader>e", function()
	fb.file_browser(themes.get_dropdown {
		previewer = false,
		hidden = true,
		cwd = vim.fn.expand("%:p:h"),
		initial_mode = "normal",

		layout_config = {
			width = 0.45,
			height = 0.45
		}
	})
end, def)

map("n", "<C-f>", function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown {
		prompt_title = "~ buffer grep ~",
		previewer = false,
		hidden = true,

		layout_config = {
			width = 0.4,
			height = 0.4,
			anchor = "NE"
		}
	})
end, def)

local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

map("n", "<leader>a", mark.add_file, def)
map("n", "<leader>j", ui.toggle_quick_menu, def)

map("n", "<F1>", function() ui.nav_file(1) end, def)
map("n", "<F2>", function() ui.nav_file(2) end, def)
map("n", "<F3>", function() ui.nav_file(3) end, def)
map("n", "<F4>", function() ui.nav_file(4) end, def)
