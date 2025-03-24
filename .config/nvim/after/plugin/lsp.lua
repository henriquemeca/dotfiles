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
local lspkind = require("lspkind")
vim.opt.completeopt = "menu,menuone,noselect"

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp" }, -- lsp
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "nvim_lua" },
		{ name = "friendly-snippets" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default
		}),
	},
})
cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
	sources = {
		{ name = "dap" },
	},
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
