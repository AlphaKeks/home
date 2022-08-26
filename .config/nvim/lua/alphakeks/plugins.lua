--[[ plugins ]]--
-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer...\nclose and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

local packer_status, packer = pcall(require, "packer")
if (not packer_status) then
	print("packer failed to load")
	return
end

packer.startup(function(use)
	-- let packer manage itself
	use { "wbthomason/packer.nvim" }

	-- theme
	use { "catppuccin/nvim", as = "catppuccin" }

	-- dependency plugins
	use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
	use { "nvim-lua/plenary.nvim", commit = "31807eef4ed574854b8a53ae40ea3292033a78ea" }

	-- LSP
	use { "nvim-treesitter/nvim-treesitter", commit = "59f656a20375242948755e860fabe3944968cbc0", run = ":TSUpdate" }
	use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "37a97a04c39f26fffe7745815517e1ce1a0eb3be" }
	use { "neovim/nvim-lspconfig", commit = "607ff48b970b89c3e4e3825b88d9cfd05b7aaea5" }
	use { "jose-elias-alvarez/null-ls.nvim", commit = "753ad51790a966b42997ac935e26573fb6d5864a" }

	-- completion
	use { "numToStr/Comment.nvim", commit = "ba5903b88c0a43fdc94abe79ade2b8291ff661ed" }
	use { "L3MON4D3/LuaSnip", commit = "04f90900f2a57938921fd25169c7f282e7eefe85" }
	use { "hrsh7th/nvim-cmp", commit = "058100d81316239f3874064064f0f0c5d43c2103" }
		use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
		use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
		use { "hrsh7th/cmp-nvim-lsp-signature-help", commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb" }
		use { "hrsh7th/cmp-emoji", commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" }
		use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }
		use { "onsails/lspkind-nvim", commit = "57e5b5dfbe991151b07d272a06e365a77cc3d0e7" }
		use { "windwp/nvim-autopairs", commit = "0a18e10a0c3fde190437567e40557dcdbbc89ea1" }
		use { "windwp/nvim-ts-autotag", commit = "044a05c4c51051326900a53ba98fddacd15fea22" }

	-- nicer UI
	use { "nvim-lualine/lualine.nvim", commit = "3cf45404d4ab5e3b5da283877f57b676cb78d41d" }
	use { "akinsho/bufferline.nvim", commit = "8383034f103a6e9c0b3178a56e27acb2215986c1" }
	use { "glepnir/lspsaga.nvim", commit = "b465e210b4fb26fe6a3312cecb1b7f6fdc1f2343" }
	use { "lewis6991/gitsigns.nvim", commit = "1e107c91c0c5e3ae72c37df8ffdd50f87fb3ebfa" }
	use { "APZelos/blamer.nvim", commit = "f4eb22a9013642c411725fdda945ae45f8d93181" }

	-- QoL
	use { "williamboman/mason.nvim", commit = "6f30a4066c477617da95ecef8f88a697d2a7124c" }
	use { "nvim-telescope/telescope.nvim", commit = "510338722e1151c116afb9467e416989159476fa" }
	use { "akinsho/toggleterm.nvim", commit = "62683d927dfd30dc68441a5811fdcb6c9f176c42" }
	use { "kyazdani42/nvim-tree.lua", commit = "c3ea264947671f44d836af5b7587e12c4b4611f9" }
	use { "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" }

if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
