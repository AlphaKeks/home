local telescope_installed, telescope = pcall(require, "telescope")
if not telescope_installed then return end

local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
	defaults = {
		mappings = {
			["i"] = {
				["<esc>"] = actions.close
			}
		}
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
			hidden = true,
			previewer = false,
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
					["<esc>"] = actions.close 
				}
			} 
		},
		-- media = {
		-- 	backend = "ueberzug",
		-- 	find_command = {
		-- 		"rg",
		-- 		"--files",
		-- 		"--glob",
		-- 		"*.{png,jpg}",
		-- 		"."
		-- 	}
		-- }
	}
})

-- telescope.load_extension("media")

local builtin = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy

local default_ivy = function(title)
	return ivy({
		prompt_title = title,
		hidden = true,
		follow = true,
		layout_config = { height = 0.4 }
	})
end

vim.keymap.set("n", "<C-f>", function()
	builtin.current_buffer_fuzzy_find({ prompt_title = "Search Buffer" })
end)
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files(default_ivy("Search Files"))
end)
vim.keymap.set("n", "<leader>fl", function()
	builtin.live_grep({
		prompt_title = "Search Project",
		glob_pattern = { "!node_modules/*", "!target/*" }
	})
end)
vim.keymap.set("n", "<leader>fd", function()
	builtin.diagnostics(default_ivy("Diagnostics"))
end)
vim.keymap.set("n", "<leader>fs", function()
	builtin.lsp_workspace_symbols(default_ivy("LSP Symbols"))
end)
vim.keymap.set("n", "<leader>fr", function()
	builtin.lsp_references(default_ivy("LSP References"))
end)
vim.keymap.set("n", "<C-/>", function()
	builtin.grep_string({
		layout_strategy = "cursor",
		layout_config = { height = 0.5, width = 0.75 }
	})
end)
vim.keymap.set("v", "<C-?>", "\"gy<cmd>lua require(\"telescope.builtin\").grep_string({ search = vim.fn.getreg(\"g\") })<cr>")

vim.keymap.set("n", "<leader>df", function()
	builtin.find_files(ivy({
		prompt_title = title,
		hidden = true,
		follow = true,
		layout_config = { height = 0.4 },
		cwd = "~/.dotfiles"
	}))
end)

telescope.load_extension("file_browser")

local function get_cwd()
	return vim.fn.expand("%:p:h")
end

vim.keymap.set("n", "<Leader>e", function()
	telescope.extensions.file_browser.file_browser(require("telescope.themes").get_dropdown({
		previewer = false,
		hidden = true,
		cwd = get_cwd(),
		initial_mode = "normal"
	}))
end)

local harpoon_installed, _ = pcall(require, "harpoon")
if harpoon_installed then
	telescope.load_extension("harpoon")
	local ui = require("harpoon.ui")
	local mark = require("harpoon.mark")

	vim.keymap.set("n", "<leader>a", mark.add_file)
	vim.keymap.set("n", "<leader>j", ui.toggle_quick_menu)
	vim.keymap.set("n", "<F1>", function() ui.nav_file(1) end)
	vim.keymap.set("n", "<F2>", function() ui.nav_file(2) end)
	vim.keymap.set("n", "<F3>", function() ui.nav_file(3) end)
	vim.keymap.set("n", "<F4>", function() ui.nav_file(4) end)
end
