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

	-- Trees
	"nvim-tree/nvim-tree.lua",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"mbbill/undotree",

	-- Harppon
	"theprimeagen/harpoon",

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
	"topaxi/gh-actions.nvim",

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
			"mxsdev/nvim-dap-vscode-js",
		},
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},

	-- Zen mode (focus on window)
	"folke/zen-mode.nvim",

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
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
	"nvim-pack/nvim-spectre",

	-- Copilot
	--"zbirenbaum/copilot.lua",
	--{
	--"zbirenbaum/copilot-cmp",
	--dependencies = { "copilot.lua" },
	--config = function()
	--require("copilot_cmp").setup()
	--end,
	--},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
	},

	-- AI Integration
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"stevearc/dressing.nvim",
		},
	},
	{
		"yetone/avante.nvim",
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			--"zbirenbaum/copilot.lua",
			"HakonHarnes/img-clip.nvim",
			"MeanderingProgrammer/render-markdown.nvim",
		},
	},

	-- Movements upgrade
	"ggandor/leap.nvim",

	-- Resurrect
	"tpope/vim-obsession",

	-- Multi Cursor
	--"mg979/vim-visual-multi",
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
