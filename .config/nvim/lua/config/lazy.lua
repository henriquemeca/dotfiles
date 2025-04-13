-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"sharkdp/fd",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ "AckslD/nvim-neoclip.lua" },

	-- Themes
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "tomasiser/vim-code-dark", name = "code-dark" },
	"Mofiqul/vscode.nvim",
	{ "catppuccin/vim", name = "catppuccin" },
	"rebelot/kanagawa.nvim",
	--{
	--"lukas-reineke/indent-blankline.nvim",
	--dependencies = {
	--"TheGLander/indent-rainbowline.nvim",
	--},
	--},
	"sphamba/smear-cursor.nvim",

	-- Trees
	"nvim-tree/nvim-tree.lua",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"mbbill/undotree",

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			"Shougo/deoplete.nvim",
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
			"cohama/lexima.vim",
			"saadparwaiz1/cmp_luasnip",
			"honza/vim-snippets",
		},
	},
	"nvimdev/lspsaga.nvim",
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	"ray-x/lsp_signature.nvim",

	-- Which key
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		version = "v2.1.0",
	},

	-- Tmux navigator
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- Smart comments
	"preservim/nerdcommenter",

	-- Auto format
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	},

	-- Git kit
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"tpope/vim-fugitive",
	"APZelos/blamer.nvim",
	"lewis6991/gitsigns.nvim",
	{ "sindrets/diffview.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	--"topaxi/gh-actions.nvim",

	-- Add persistence to files
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
	},

	-- DAP-debugger
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
			"leoluz/nvim-dap-go",
		},
	},

	-- Zen mode (focus on window)
	"folke/zen-mode.nvim",

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		version = "v0.0.10",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "echasnovski/mini.nvim", optional = true },
		config = function()
			require("render-markdown").setup({})
		end,
	},

	-- Buffer line plugin
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	-- Find and replace tool
	"MagicDuck/grug-far.nvim",

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
	},

	-- AI Integration
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	-- Go features
	{
		"olexsmir/gopher.nvim",
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},

	-- Movements upgrade
	"ggandor/leap.nvim",

	-- Resurrect
	"tpope/vim-obsession",

	-- Multi Cursor
	--"mg979/vim-visual-multi",
	--"terryma/vim-multiple-cursors",

	-- Snippets

	{
		"chrisgrieser/nvim-scissors",
		dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
	},
}

require("lazy").setup(plugins, {
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			-- disable unused builtin plugins from neovim
			disabled_plugins = {
				"gzip",
				"health",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"rplugin",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zip",
				"zipPlugin",
			},
		},
	},
})
