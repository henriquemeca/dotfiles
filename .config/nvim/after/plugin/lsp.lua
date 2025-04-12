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
		"intelephense",
		--"gopls",
		--"terraformls",
		--"emmet-language-server",
		--"tsserver", --typescript
		--"eslint-lsp",
		--"prettier",
		--"js-debug-adapter",
		--"php-cs-fixer",
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
		--["ruff"] = function()
		--local lspconfig = require("lspconfig")
		--lspconfig.ruff.setup({
		--capabilities = capabilities,
		--trace = "messages",
		--init_options = {
		--settings = {
		--logLevel = "debug",
		--},
		--},
		--})
		--end,
		--["ruff_lsp"] = function()
		--local lspconfig = require("lspconfig")
		--lspconfig.ruff_lsp.setup({
		--capabilities = capabilities,
		--})
		--end,
		["pyright"] = function()
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				settings = {
					single_file_support = true,
					pyright = {
						disableLanguageServices = false,
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							ignoredFiles = { ".*" },
							logLevel = "Trace",
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
		["ts_ls"] = function()
			require("lspconfig").ts_ls.setup({})
		end,
		["intelephense"] = function()
			require("lspconfig").intelephense.setup({})
		end,
		["gopls"] = function()
			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = require("lspconfig/util").root_pattern("gowork", "gomod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
		end,
		["emmet_ls"] = function()
			require("lspconfig").emmet_ls.setup({
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
				},
				-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
				-- **Note:** only the options listed in the table are supported.
				init_options = {
					---@type table<string, string>
					includeLanguages = {},
					--- @type string[]
					excludeLanguages = {},
					--- @type string[]
					extensionsPath = {},
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
					preferences = {},
					--- @type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					--- @type "always" | "never" Defaults to `"always"`
					showExpandedAbbreviation = "always",
					--- @type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
					syntaxProfiles = {},
					--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
					variables = {},
				},
			})
		end,
		["phpactor"] = function()
			require("lspconfig").phpactor.setup({})
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
