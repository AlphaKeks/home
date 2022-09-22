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
	use { "nvim-treesitter/nvim-treesitter", commit = "cd9dfc1e48e8ad27b75cf883ba036e83b7079b9a" }
	use { "neovim/nvim-lspconfig", commit = "1fcd44ef5f5ada6b2d9b29001aa91e352f9b6c76" }
	use { "hrsh7th/nvim-cmp", commit = "913eb8599816b0b71fe959693080917d8063b26a" }

	use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
	use { "hrsh7th/cmp-nvim-lsp-signature-help", commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb" }
	use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }

	use { "L3MON4D3/LuaSnip", commit = "04f90900f2a57938921fd25169c7f282e7eefe85" }
	use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }

	use { "windwp/nvim-autopairs", commit = "5fe24419e7a7ec536d78d60be1515b018ab41b15" }
	use { "windwp/nvim-ts-autotag", commit = "fdefe46c6807441460f11f11a167a2baf8e4534b" }
	use { "numToStr/Comment.nvim", commit = "30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6" }

	use { "nvim-telescope/telescope.nvim", commit = "2584ff391b528d01bf5e8c04206d5902a79ebdde" }
	use { "nvim-telescope/telescope-file-browser.nvim", commit = "60bcf4e70ecb9392445c2a2205ee8181dff964d5" }
	use { "ThePrimeagen/harpoon", commit = "f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971" }

	use { "jose-elias-alvarez/null-ls.nvim", commit = "753ad51790a966b42997ac935e26573fb6d5864a" }
	use { "williamboman/mason.nvim", commit = "6f30a4066c477617da95ecef8f88a697d2a7124c" }
	use { "feline-nvim/feline.nvim", commit = "331a79449d86668618a4e00fced153bce3ce2780" }
	use { "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" }
	use { "akinsho/toggleterm.nvim", commit = "7abb25ec913b4edf4c0384346da0999726a3d7be" }

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)
