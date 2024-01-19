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

    use("nvim-tree/nvim-tree.lua")
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use({
        "neovim/nvim-lspconfig",
        -- branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            --- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            --Formatters and linters
            { "jose-elias-alvarez/null-ls.nvim" },
            { "mhartington/formatter.nvim" },
            { "mfussenegger/nvim-lint" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/nvim-cmp" },

            -- Lua snipets
            { "L3MON4D3/LuaSnip",                 requires = { "rafamadriz/friendly-snippets" } },
            { "saadparwaiz1/cmp_luasnip" },

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

    -- Smart comments
    use({ "preservim/nerdcommenter" })

    -- auto format
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
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
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- Vim LSP
    use("prabirshrestha/vim-lsp")
    -- LSP navigator
    use({
        "ray-x/navigator.lua",
        requires = {
            { "ray-x/guihua.lua",     run = "cd lua/fzy && make" },
            { "neovim/nvim-lspconfig" },
        },
    })
    -- Signature help
    use({
        "ray-x/lsp_signature.nvim",
    })
    -- Trouble diagnostics
    use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
    -- Fidget notifications
    use({ "j-hui/fidget.nvim" })
    -- DAP -debbuger
    use({
        "mfussenegger/nvim-dap",
        requires = {
            { "rcarriga/nvim-dap-ui" },
            { "williamboman/mason.nvim" },
            { "jbyuki/one-small-step-for-vimkind" },
            { "jay-babu/mason-nvim-dap.nvim" },
            { "leoluz/nvim-dap-go" },
            { "theHamsta/nvim-dap-virtual-text" },
        },
    })
    -- Zen mode (focus on window)
    use("folke/zen-mode.nvim")
end)
