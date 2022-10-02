local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"git@github.com:wbthomason/packer.nvim",
		packer_path
	}

	print "Installing packer...\nclose and reopen neovim once the installation has finished."
	vim.cmd "packadd packer.nvim"
end

local ok, packer = pcall(require, "packer")
if not ok then
	print "PACKER FAILED TO LOAD."
	return
end

packer.startup(function(use)
	use { "wbthomason/packer.nvim" }
	use { "catppuccin/nvim", as = "catppuccin" }

	use { "nvim-lua/plenary.nvim" }
	use { "nvim-treesitter/nvim-treesitter" }
	use { "neovim/nvim-lspconfig" }
	use { "hrsh7th/nvim-cmp" }

	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lsp-signature-help" }
	use { "hrsh7th/cmp-path" }

	use { "L3MON4D3/LuaSnip" }
	use { "saadparwaiz1/cmp_luasnip" }

	use { "windwp/nvim-autopairs" }
	use { "windwp/nvim-ts-autotag" }
	use { "numToStr/Comment.nvim" }

	use { "nvim-telescope/telescope.nvim" }
	use { "nvim-telescope/telescope-file-browser.nvim" }
	use { "ThePrimeagen/harpoon" }

	use { "jose-elias-alvarez/null-ls.nvim" }
	use { "williamboman/mason.nvim" }
	use { "feline-nvim/feline.nvim" }
	use { "lewis6991/gitsigns.nvim" }
	use { "kyazdani42/nvim-web-devicons" }
	use { "akinsho/toggleterm.nvim" }

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)
