local M = {}

M.PackerSetup = function()
	local packer_installed, packer = pcall(require, "packer")
	if not packer_installed then return end

	packer.startup(function(use)
		use("wbthomason/packer.nvim") -- packer can update itself
		use({ "catppuccin/nvim", as = "catppuccin" }) -- colorscheme
		use({
			"nvim-treesitter/nvim-treesitter", -- tree-sitter
			requires = {
				"windwp/nvim-autopairs", -- automatically close (,[,{ etc.
				"windwp/nvim-ts-autotag", -- automatically close html tags
				"numToStr/Comment.nvim", -- comment stuff using tree-sitter
				"nvim-treesitter/playground"
			}
		})
		use({
			"hrsh7th/nvim-cmp", -- completion engine
			requires = {
				"hrsh7th/cmp-buffer", -- suggest buffer words for completion
				"hrsh7th/cmp-path", -- suggest filesystem paths for completion
				"L3MON4D3/LuaSnip", -- snippet engine
				"saadparwaiz1/cmp_luasnip" -- suggest snippets for completion
			}
		})
		use({
			"nvim-telescope/telescope.nvim", -- blazingly fast fuzzy finding
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-file-browser.nvim", -- blazingly fast file browser
				"ThePrimeagen/harpoon", -- blazingly fast marks (but better™)
				-- "dharmx/telescope-media.nvim"
			}
		})
		use("TimUntersberger/neogit")
		use({
			"neovim/nvim-lspconfig", -- LSP configurations
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"jose-elias-alvarez/null-ls.nvim", -- custom language server for linters/formatters
				"simrat39/rust-tools.nvim", -- rust-analyzer extended™
				"williamboman/mason.nvim", -- install LSP-related dependencies easily
				"glepnir/lspsaga.nvim" -- nicer LSP UIs
			}
		})
		use({
			"feline-nvim/feline.nvim", -- statusline
			requires = {
				"lewis6991/gitsigns.nvim", -- git integration
				"kyazdani42/nvim-web-devicons" -- cool icons
			}
		})
		use({
			"shortcuts/no-neck-pain.nvim",
			tag = "*"
		})
		use({
			"jackMort/ChatGPT.nvim",
			requires = { "MunifTanjim/nui.nvim" }
		})
	end)
end

local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	-- ask for packer installation if it's not installed
	vim.ui.input({ prompt = "Install packer? [y/n] " }, function(packer_choice)
		packer_choice = string.lower(packer_choice)
		if packer_choice == "y" or packer_choice == "yes" then
			vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
			print("Installing packer...")
			vim.cmd.packadd("packer.nvim")

			-- also ask for plugin installation
			vim.ui.input({ prompt = "Install plugins? [y/n] " }, function(plugin_choice)
				plugin_choice = string.lower(plugin_choice)
				if plugin_choice == "y" or plugin_choice == "yes" then
					print("Installing plugins...")
					print("Close and reopen neovim once the installation has finished.")
					PackerSetup()
					vim.cmd.PackerSync()
				end
			end)
		end
	end)
end

return M
