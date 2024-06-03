vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		-- Enable completion triggered by <c-x><c-o>lsp
		--vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end
	end,
})

-- Cmp config
local cmp = require("cmp")
--require("luasnip.loaders.from_vscode").load()
local luasnip = require("luasnip")
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	sources = {
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "friendly-snippets" },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
})

-- Copilot setup
cmp.event:on("menu_opened", function()
	vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
	vim.b.copilot_suggestion_hidden = false
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
		"tsserver", --typescript
		"eslint-lsp",
		"prettier",
		"js-debug-adapter",
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
		["tsserver"] = function()
			require("lspconfig").tsserver.setup({
				capabilities = capabilities,
				init_options = {
					preferences = {
						--importModuleSpecifierPreference = "relative",
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
