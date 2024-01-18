local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	require("which-key").register({
		["<leader>n"] = { name = "+Lsp Navigator" },
		["<leader>nc"] = { name = "+code/calls" },
		["<leader>nl"] = { name = "lens" },
		["<leader>nw"] = { name = "+workspace" },
	})
end)

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
		"taplo", --TOML
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
		pyright = function()
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				settings = {
					single_file_support = true,
					pyright = {
						disableLanguageServices = false,
						disableOrganizeImports = false,
					},
					plugins = {
						-- formatter options
						black = { enabled = true },
						autopep8 = { enabled = false },
						yapf = { enabled = false },
						-- linter options
						pylint = { enabled = true, executable = "pylint" },
						pyflakes = { enabled = false },
						pycodestyle = { enabled = false },
						-- type checker
						pylsp_mypy = { enabled = true },
						-- auto-completion options
						jedi_completion = { fuzzy = true },
						-- import sorting
						pyls_isort = { enabled = true },
					},
					python = {
						analysis = {
							extraPaths = "",
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

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "friendly-snippets" },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

require("navigator").setup({
	mason = true,
	default_mapping = false,
	keymaps = {
		{ key = "<Leader>nr", func = require("navigator.reference").async_ref, desc = "async_ref" },
		{ key = "<Leader>n0", func = require("navigator.symbols").document_symbols, desc = "document_symbols" },
		{
			key = "<Leader>nW",
			func = require("navigator.workspace").workspace_symbol_live,
			desc = "workspace_symbol_live",
		},
		{ key = "<Leader>nd", func = require("navigator.definition").definition, desc = "definition" },
		{ key = "<Leader>nD", func = vim.lsp.buf.declaration, desc = "declaration" },
		{
			key = "<Leader>np",
			func = require("navigator.definition").definition_preview,
			desc = "definition_preview",
		},
		{ key = "<Leader>nn", func = require("navigator.rename").rename, desc = "rename" },
		--{
		--key = "<Leader>nP",
		--func = require("navigator.definition").type_definition_preview,
		--desc = "type_definition_preview",
		--},
		{ key = "<Leader>na", func = require("navigator.treesitter").buf_ts, desc = "buf_ts" },
		{
			key = "<Leader>nca",
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
			func = require("navigator.diagnostics").show_buf_diagnostics,
			desc = "show_buf_diagnostics",
		},
		{
			key = "<Leader>nt",
			func = require("navigator.diagnostics").toggle_diagnostics,
			desc = "toggle_diagnostics",
		},
		--{
		--key = "]d",
		--func = vim.diagnostic.goto_next,
		--desc = "next diagnostics",
		--},
		--{
		--key = "[d",
		--func = vim.diagnostic.goto_prev,
		--desc = "prev diagnostics",
		--},
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
	},
})
vim.keymap.set("n", "<leader>nk", "<cmd>LspKeymaps<cr>", { desc = "Show keymaps" })
