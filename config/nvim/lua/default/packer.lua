-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "tomasiser/vim-code-dark", as = "code-dark" })
	use("Mofiqul/vscode.nvim")

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({
		"VonHeikemen/lsp-zero.nvim",
		-- branch = 'v3.x',
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			--- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			-- {'williamboman/mason.nvim'},
			-- {'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "jiangmiao/auto-pairs" },
		},
	})
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use({
		"christoomey/vim-tmux-navigator",
		lazy = false,
	})
	use({
		"ms-jpq/chadtree",
		branch = "chad",
		run = "python3 -m chadtree deps",
	})

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- Python auto complete
	use("Shougo/deoplete.nvim")
	use({
		"zchee/deoplete-jedi",
		run = "pip install pynvim jedi",
	})

	use({ "davidhalter/jedi-vim", as = "jedi-vim" })

	-- Smart comments
	use({ "preservim/nerdcommenter" })

	-- auto format
	use({
		"sbdchd/neoformat",
		run = "python3 -m yapf",
	})

	-- Git commit preview
	use("cohama/agit.vim")
	-- Git Browser
	use("tpope/vim-rhubarb")
	-- Git Sign
	use("airblade/vim-gitgutter")
	-- Git Blame
	use("APZelos/blamer.nvim")
	-- Debugger
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	-- Diff view on github
	use({ "sindrets/diffview.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
	-- Add  persistance to files
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
	})
	-- Lazy git
	-- nvim v0.7.2
	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
end)
