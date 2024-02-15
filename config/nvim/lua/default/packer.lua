-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use { "AckslD/nvim-neoclip.lua", }

    -- Themes
    use({ "rose-pine/neovim", as = "rose-pine" })
    use({ "tomasiser/vim-code-dark", as = "code-dark" })
    use("Mofiqul/vscode.nvim")
    use { 'catppuccin/vim', as = 'catppuccin' }

    -- Trees
    use("nvim-tree/nvim-tree.lua")
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("mbbill/undotree")

    -- Harppon
    use("theprimeagen/harpoon")

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        -- branch = 'v3.x',
        requires = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            ----Formatters and linters
            --{ "jose-elias-alvarez/null-ls.nvim" },
            --{ "mhartington/formatter.nvim" },
            --{ "mfussenegger/nvim-lint" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            --{ "hrsh7th/cmp-nvim-lsp" },
            --{ "hrsh7th/cmp-buffer" },
            --{ "hrsh7th/cmp-path" },
            --{ "hrsh7th/cmp-cmdline" },
            --{ "hrsh7th/nvim-cmp" },

            -- Lua snipets
            { "L3MON4D3/LuaSnip",                 requires = { "rafamadriz/friendly-snippets" } },
            { "cohama/lexima.vim" },
            --{ "saadparwaiz1/cmp_luasnip" },

        },
    })
    use({
        'nvimdev/lspsaga.nvim',
    })
    use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
    use({
        "ray-x/lsp_signature.nvim",
    })

    -- Which key
    use({
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    })
    -- Tmux navigator
    use({
        "christoomey/vim-tmux-navigator",
        lazy = false,
    })

    -- Smart comments
    use({ "preservim/nerdcommenter" })

    -- Auto format
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    })

    --Git kit
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    use("tpope/vim-fugitive")
    use("APZelos/blamer.nvim")
    use 'lewis6991/gitsigns.nvim'
    use({ "sindrets/diffview.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            -- OR 'ibhagwan/fzf-lua',
            'nvim-tree/nvim-web-devicons',
        },
    }

    -- Add  persistance to files
    use({
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
    })

    -- DAP-debbuger
    use({
        "rcarriga/nvim-dap-ui",
        requires = {
            { "mfussenegger/nvim-dap" },
            { "williamboman/mason.nvim" },
            --{ "jbyuki/one-small-step-for-vimkind" },
            { "jay-babu/mason-nvim-dap.nvim" },
            --{ "theHamsta/nvim-dap-virtual-text" },
        },
    })

    -- Zen mode (focus on window)
    use("folke/zen-mode.nvim")

    -- Markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Buffer line plugin
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

    -- Find and replace tool
    --use 'nvim-lua/plenary.nvim'
    use 'nvim-pack/nvim-spectre'

    -- Copilot
    use { "zbirenbaum/copilot.lua" }
    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Gpt Integration
    use({
        "jackMort/ChatGPT.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })
    -- Movements upgrade
    use "ggandor/leap.nvim"
    -- Help with vim best practices
    use { "m4xshen/hardtime.nvim",
        requires = {
            { "MunifTanjim/nui.nvim" },
            { "nvim-lua/plenary.nvim" } },
        confg = function()
            require("hardtime").setup()
            vim.cmd("Hardtime enable")
        end
    }
end)
