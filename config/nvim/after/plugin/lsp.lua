-- LSP LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        ---- Enable completion triggered by <c-x><c-o>
        --vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'


        ---- See `:help vim.lsp.*` for documentation on any of the below functions
        --local function opts(description)
        --return { buffer = ev.buf, desc = description }
        --end
        --vim.keymap.set('n', '<leader>nD', vim.lsp.buf.declaration, opts("Go to declaration"))
        --vim.keymap.set('n', '<leader>nd', vim.lsp.buf.definition, opts("Go to definition"))
        --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts("Hover"))
        --vim.keymap.set('n', '<leader>ni', vim.lsp.buf.implementation, opts("Go to implementation"))
        --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts("Signature_help"))
        --vim.keymap.set('n', '<leader>nwa', vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
        --vim.keymap.set('n', '<leader>nwr', vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
        --vim.keymap.set('n', '<leader>nwl', function()
        --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, opts("List workspace folders "))
        --vim.keymap.set('n', '<leader>nrn', vim.lsp.buf.rename, opts("Rename"))
        --vim.keymap.set({ 'n', 'v' }, '<leader>na', vim.lsp.buf.code_action, opts("Code Actions"))
        --vim.keymap.set('n', '<leader>nr', vim.lsp.buf.references, opts("References"))

        --vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        WHICH_KEY_MAP({
            ["<leader>n"] = { name = "+Lsp Navigator" },
            ["<leader>nw"] = { name = "+workspace" },
        })
    end,
})

-- Cmp config
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").load()
local luasnip = require("luasnip")
luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    sources = {
        { name = "luasnip",          option = { show_autosnippets = true } },
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "friendly-snippets" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        --['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --['<C-f>'] = cmp.mapping.scroll_docs(4),
        --['<C-Space>'] = cmp.mapping.complete(),
        --['<C-e>'] = cmp.mapping.abort(),
    }),
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
        "bashls",
        "dockerls",
        "docker_compose_language_service",
        "jsonls",
        "lua_ls",
        "marksman", --markdown
        "sqlls",
        "taplo",    --TOML
    },
    handlers = {
        -- Default handler
        function(server)
            require("lspconfig")[server].setup({
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
        ["pyright"] = function()
            require("lspconfig").pyright.setup({
                capabilities = capabilities,
                settings = {
                    single_file_support = true,
                    pyright = {
                        disableLanguageServices = false,
                        disableOrganizeImports = false,
                    },
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            autoImportCompletions = true,
                            diagnosticMode = "openFilesOnly",
                        },
                    },
                },
            })
        end,
    },
})


-- Inspect source function
local function inspect_config_source(input)
    local server = input.args
    local mod = "lua/lspconfig/server_configurations/%s.lua"
    local path = vim.api.nvim_get_runtime_file(mod:format(server), 0)

    if path[1] == nil then
        local msg = "[lsp-zero] Could not find configuration for '%s'"
        vim.notify(msg:format(server), vim.log.levels.WARN)
        return
    end

    vim.cmd.sview({
        args = { path[1] },
        mods = { vertical = true },
    })
end

vim.api.nvim_create_user_command("LspViewConfigSource", inspect_config_source, {
    nargs = 1,
})

require("navigator").setup({
    mason = true, -- set to true if you would like use the lsp installed by williamboman/mason
    default_mapping = false,
    --on_attach = function(client, bufnr)
    --end,
    keymaps = {
        { key = "<Leader>nr", func = require("navigator.reference").async_ref,      desc = "async_ref" },
        { key = "<Leader>n0", func = require("navigator.symbols").document_symbols, desc = "document_symbols" },
        {
            key = "<Leader>nW",
            func = require("navigator.workspace").workspace_symbol_live,
            desc = "workspace_symbol_live",
        },
        { key = "<Leader>nd", func = require("navigator.definition").definition, desc = "definition" },
        { key = "<Leader>nD", func = vim.lsp.buf.declaration,                    desc = "declaration" },
        {
            key = "<Leader>np",
            func = require("navigator.definition").definition_preview,
            desc = "definition_preview",
        },
        { key = "<Leader>nn", func = require("navigator.rename").rename,          desc = "rename" },
        --{
        --key = "<Leader>nP",
        --func = require("navigator.definition").type_definition_preview,
        --desc = "type_definition_preview",
        --},
        --{ key = "<Leader>na", func = require("navigator.treesitter").buf_ts, desc = "buf_ts" },
        {
            key = "<Leader>na",
            mode = "n",
            func = require("navigator.codeAction").code_action,
            desc = "code_action",
        },
        {
            key = "<Leader>nci",
            func = vim.lsp.buf.incoming_calls,
            desc = "incoming_calls",
        },
        {
            key = "<Leader>nco",
            func = vim.lsp.buf.outgoing_calls,
            desc = "outgoing_calls",
        },
        {
            key = "<Leader>ni",
            func = vim.lsp.buf.implementation,
            desc = "implementation",
        },
        {
            key = "<Leader>nL",
            func = require("navigator.diagnostics").show_diagnostics,
            desc = "show_diagnostics",
        },
        {
            key = "<Leader>nG",
            func = require("telescope.builtin").diagnostics, --require("navigator.diagnostics").show_buf_diagnostics,
            desc = "show_buf_diagnostics",
        },
        {
            key = "<Leader>nT",
            func = function()
                if vim.g.diagnostics_active then
                    vim.g.diagnostics_active = false
                    vim.lsp.diagnostic.clear(0)
                    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
                else
                    vim.g.diagnostics_active = true
                    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                        vim.lsp.diagnostic.on_publish_diagnostics, {
                            virtual_text = true,
                            signs = true,
                            underline = true,
                            update_in_insert = false,
                        }
                    )
                end
            end,
            desc = "toggle_diagnostics",
        },
        {
            key = "]d",
            func = vim.diagnostic.goto_next,
            desc = "next diagnostics",
        },
        {
            key = "[d",
            func = vim.diagnostic.goto_prev,
            desc = "prev diagnostics",
        },
        --{
        --key = "]O",
        --func = vim.diagnostic.set_loclist,
        --desc = "diagnostics set loclist",
        --},
        --{
        --key = "]r",
        --func = require("navigator.treesitter").goto_next_usage,
        --desc = "<Leader>noto_next_usage",
        --},
        --{
        --key = "[r",
        --func = require("navigator.treesitter").goto_previous_usage,
        --desc = "<Leader>noto_previous_usage",
        --},
        --{ key = "<C-LeftMouse>", func = vim.lsp.buf.definition, desc = "definition" },
        --{
        --key = "<Leader>n<LeftMouse>",
        --func = vim.lsp.buf.implementation,
        --desc = "implementation",
        --},
        --{ key = "<Space>ff", func = vim.lsp.buf.format,                          mode = "n",        desc = "format" },
        --{
        --key = "<Space>ff",
        --func = vim.lsp.buf.range_formatting,
        --mode = "v",
        --desc = "range format",
        --},
        { key = "<Leader>nh", func = require("navigator.dochighlight").hi_symbol, desc = "hi_symbol" },
        {
            key = "<Leader>nwa",
            func = require("navigator.workspace").add_workspace_folder,
            desc = "add_workspace_folder",
        },
        {
            key = "<Leader>nwr",
            func = require("navigator.workspace").remove_workspace_folder,
            desc = "remove_workspace_folder",
        },
        --{
        --key = "<Space>gm",
        --func = require("navigator.formatting").range_format,
        --mode = "n",
        --desc = "range format operator e.g gmip",
        --},
        {
            key = "<Leader>nwl",
            func = require("navigator.workspace").list_workspace_folders,
            desc = "list_workspace_folders",
        },
        {
            key = "<Leader>nla",
            mode = "n",
            func = require("navigator.codelens").run_action,
            desc = "run code lens action",
        },
        {
            vim.keymap.set("n", "<leader>nk", "<cmd>LspKeymaps<cr>", { desc = "Show keymaps" }),
        },
        {
            key = "<Leader>nwl",
            func = require("navigator.workspace").list_workspace_folders,
            desc = "list_workspace_folders",
        },
        {
            key = "<Leader>nla",
            mode = "n",
            func = require("navigator.codelens").run_action,
            desc = "run code lens action",
        },
    },
    treesitter_analysis = true,          -- treesitter variable context
    treesitter_navigation = true,        -- bool|table false: use lsp to navigate between symbol ']r/[r', table: a list of
    --lang using TS navigation
    treesitter_analysis_max_num = 100,   -- how many items to run treesitter analysis
    treesitter_analysis_condense = true, -- condense form for treesitter analysis
    -- this value prevent slow in large projects, e.g. found 100000 reference in a project
    transparency = 50,                   -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it

    lsp_signature_help = true,           -- if you would like to hook ray-x/lsp_signature plugin in navigator
    -- setup here. if it is nil, navigator will not init signature help
    signature_help_cfg = nil,            -- if you would like to init ray-x/lsp_signature plugin in navigator, and pass in your own config to signature help
    icons = {                            -- refer to lua/navigator.lua for more icons config
        -- requires nerd fonts or nvim-web-devicons
        icons = false,
        -- Code action
        code_action_icon = "🏏", -- note: need terminal support, for those not support unicode, might crash
        -- Diagnostics
        diagnostic_head = '🐛',
        diagnostic_head_severity_1 = "🈲",
        fold = {
            prefix = '⚡', -- icon to show before the folding need to be 2 spaces in display width
            separator = '', -- e.g. shows   3 lines 
        },
    },
    lsp = {
        enable = true, -- skip lsp setup, and only use treesitter in navigator.
        -- Use this if you are not using LSP servers, and only want to enable treesitter support.
        -- If you only want to prevent navigator from touching your LSP server configs,
        -- use `disable_lsp = "all"` instead.
        -- If disabled, make sure add require('navigator.lspclient.mapping').setup({bufnr=bufnr, client=client}) in your
        -- own on_attach
        code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
        code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
        document_highlight = true, -- LSP reference highlight,
        -- it might already supported by you setup, e.g. LunarVim
        format_on_save = true,     -- {true|false} set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
        -- table: {enable = {'lua', 'go'}, disable = {'javascript', 'typescript'}} to enable/disable specific language
        -- enable: a whitelist of language that will be formatted on save
        -- disable: a blacklist of language that will not be formatted on save
        -- function: function(bufnr) return true end to enable/disable lsp format on save
        format_options = { async = false },                  -- async: disable by default, the option used in vim.lsp.buf.format({async={true|false}, name = 'xxx'})
        disable_format_cap = { "sqlls", "lua_ls", "gopls" }, -- a list of lsp disable format capacity (e.g. if you using efm or vim-codeformat etc), empty {} by default
        -- If you using null-ls and want null-ls format your code
        -- you should disable all other lsp and allow only null-ls.
        -- disable_lsp = {'pylsd', 'sqlls'},  -- prevents navigator from setting up this list of servers.
        -- if you use your own LSP setup, and don't want navigator to setup
        -- any LSP server for you, use `disable_lsp = "all"`.
        -- you may need to add this to your own on_attach hook:
        -- require('navigator.lspclient.mapping').setup({bufnr=bufnr, client=client})
        -- for e.g. denols and tsserver you may want to enable one lsp server at a time.
        -- default value: {}
        diagnostic = {
            underline = true,
            virtual_text = true,      -- show virtual for diagnostic message
            update_in_insert = false, -- update diagnostic message in insert mode
            float = {                 -- setup for floating windows style
                focusable = false,
                sytle = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
        },

        hover = {
            enable = true,
            keymap = {
                ['<C-k>'] = {
                    go = function()
                        local w = vim.fn.expand('<cWORD>')
                        vim.cmd('GoDoc ' .. w)
                    end,
                    default = function()
                        local w = vim.fn.expand('<cWORD>')
                        vim.lsp.buf.workspace_symbol(w)
                    end,
                },
            }
        },
        diagnostic_scrollbar_sign = { '▃', '▆', '█' }, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign,
        --                for other style, set to {'╍', 'ﮆ'} or {'-', '='}
        diagnostic_virtual_text = true, -- show virtual for diagnostic message
        diagnostic_update_in_insert = false, -- update diagnostic message in insert mode
        display_diagnostic_qf = true, -- always show quickfix if there are diagnostic errors, set to false if you want to ignore it
    }
})
vim.keymap.set("n", "<leader>nk", "<cmd>LspKeymaps<cr>", { desc = "Show keymaps" })
