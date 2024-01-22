-- LSP LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'


        ---- See `:help vim.lsp.*` for documentation on any of the below functions
        --local function opts(description)
        --return { buffer = ev.buf, desc = description }
        --end
        --vim.keymap.set('n', '<leader>nD', vim.lsp.buf.declaration, opts("Go to declaration"))
        --vim.keymap.set('n', '<leader>nd', vim.lsp.buf.definition, opts("Go to definition"))
        --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts("Hover"))
        --vim.keymap.set('n', '<leader>ni', vim.lsp.buf.implementation, opts("Go to implementation"))
        --vim.keymap.set('n', '<leader>nwa', vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
        --vim.keymap.set('n', '<leader>nwr', vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
        --vim.keymap.set('n', '<leader>nwl', function()
        --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, opts("List workspace folders "))
        --vim.keymap.set('n', '<leader>nrn', vim.lsp.buf.rename, opts("Rename"))
        --vim.keymap.set({ 'n', 'v' }, '<leader>na', vim.lsp.buf.code_action, opts("Code Actions"))
        --vim.keymap.set('n', '<leader>nr', vim.lsp.buf.references, opts("References"))

        --vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        --VKSN('<C-k>', vim.lsp.buf.signature_help, opts("Signature_help"))
        --VKSN('K', vim.lsp.buf.hover, opts("Hover"))
        --VKSN("<leader>nr", require("telescope.builtin").lsp_references, opts("references"))
        --VKSN("<leader>n0", "<cmd>Telescope lsp_document_symbols<cr>", opts("document_symbols"))
        --VKSN('<leader>nwa', vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
        --VKSN('<leader>nwr', vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
        --VKSN('<leader>nwl', function()
        --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, opts("List workspace folders "))
        --VKSN("<leader>nd", vim.lsp.buf.definition, opts("Go to definition"))
        --VKSN("<leader>nD", vim.lsp.buf.declaration, opts("Go to declaration"))
        --VKSN("<Leader>nn", vim.lsp.buf.rename, opts("rename"))
        --VKSN("<Leader>na", vim.lsp.buf.code_action, opts("code_action"))
        --VKSN("<Leader>ni", vim.lsp.buf.implementation, opts("implementation"))
        --VKSN("<Leader>nG", require("telescope.builtin").diagnostics, opts("show_buf_diagnostics"))
        --VKSN(
        --"<Leader>nT",
        --function()
        --if vim.g.diagnostics_active then
        --vim.g.diagnostics_active = false
        --vim.lsp.diagnostic.clear(0)
        --vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
        --else
        --vim.g.diagnostics_active = true
        --vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        --vim.lsp.diagnostic.on_publish_diagnostics, {
        --virtual_text = true,
        --signs = true,
        --underline = true,
        --update_in_insert = false,
        --}
        --)
        --end
        --end,
        --opts("toggle_diagnostics"))
        --VKSN("]d", vim.diagnostic.goto_next, opts("next diagnostics"))
        --VKSN("[d", vim.diagnostic.goto_prev, opts("prev diagnostics"))
        --VKSN("<Leader>nff", vim.lsp.buf.format, opts("format"))
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
