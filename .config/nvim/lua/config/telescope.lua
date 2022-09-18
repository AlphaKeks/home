local ok, telescope = pcall(require, 'telescope')
if not ok then
	print 'telescope failed to load.'
	return
end

local actions = require('telescope.actions')
local fb_actions = require('telescope').extensions.file_browser.actions

telescope.setup {
	defaults = {
		prompt_prefix = '  ',
		selection_caret = ' ',
		path_display = { 'smart' },
		mappings = {
			i = {
				['<Down>'] = actions.cycle_history_next,
				['<Up>'] = actions.cycle_history_prev,
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,
			}
		}
	},
	extensions = {
		file_browser = {
			theme = 'dropdown',
			hijack_netrw = true,
			hidden = true,
			mappings = {
				['n'] = {
					['a'] = fb_actions.create,
					['d'] = fb_actions.remove,
					['r'] = fb_actions.rename
				},
				['i'] = {
					['<C-a>'] = fb_actions.create,
					['<C-d>'] = fb_actions.remove,
					['<C-r>'] = fb_actions.rename
				}
			}
		}
	}
}

telescope.load_extension('file_browser')
telescope.load_extension('harpoon')

local h_ok, h = pcall(require, 'alphakeks.keymaps')
if not h_ok then
	print 'keymaps failed to load.'
	return
end

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

h.map('n', '<leader>ff', function()
	builtin.find_files(themes.get_dropdown {
		prompt_title = 'Fuzzy Find',
		previewer = false,
		hidden = true,
		layout_config = {
			anchor = 'N',
		}
	})
end, h.def)

h.map('n', '<leader>fl', function()
	builtin.live_grep(themes.get_dropdown {
		prompt_title = 'Live Grep',
		previewer = true,
		layout_config = {
			anchor = 'NE',
		}
	})
end, h.def)

h.map('n', '<leader>fg', function()
	builtin.git_status {
		prompt_title = 'Git Status',
		initial_mode = 'normal',
		hidden = true,
		layout_config = {
			height = 0.75,
			width = 0.75,
		}
	}
end, h.def)

h.map('n', '<leader><Tab>', function()
	builtin.buffers(themes.get_dropdown {
		prompt_title = 'Buffers',
		previewer = false,
		initial_mode = 'normal',
		sort_lastused = true,
		sort_mru = true,
		layout_config = {
			prompt_position = 'bottom'
		}
	})
end, h.def)

h.map('n', '<leader>fd', function()
	builtin.find_files(themes.get_dropdown {
		prompt_title = '~/.dotfiles',
		cwd = '~/.dotfiles',
		previewer = false,
		hidden = true,
		layout_config = {
			height = 0.35
		}
	})
end, h.def)

h.map('n', '<C-f>', function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown {
		prompt_title = 'Fuzzy Search',
		previewer = false,
		layout_config = {
			anchor = 'NE'
		}
	})
end, h.def)

h.map('n', '<leader>e', function()
	telescope.extensions.file_browser.file_browser {
		initial_mode = 'normal',
		cwd = vim.fn.expand('%:p:h'),
		previewer = false,
		layout_config = {
			height = 0.75,
			width = 0.75
		}
	}
end, h.def)

local ui = require('harpoon.ui')
local mark = require('harpoon.mark')

h.map('n', '<leader>a', function() mark.add_file() end, h.def)
h.map('n', '<leader>j', function() ui.toggle_quick_menu() end, h.def)

h.map('n', '<leader>1', function() ui.nav_file(1) end, h.def)
h.map('n', '<leader>2', function() ui.nav_file(2) end, h.def)
h.map('n', '<leader>3', function() ui.nav_file(3) end, h.def)
h.map('n', '<leader>4', function() ui.nav_file(4) end, h.def)
