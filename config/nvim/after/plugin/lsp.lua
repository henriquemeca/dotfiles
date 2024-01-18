local lsp_zero = require("lsp-zero")

local set_nkeymap = function(map, func, bufnr, description)
	vim.keymap.set("n", map, func, { buffer = bufnr, remap = false, desc = description })
end

lsp_zero.on_attach(function(client, bufnr)
	set_nkeymap("K", function()
		vim.lsp.buf.hover()
	end, bufnr, "hover")
	--set_nkeymap("<leader>vws", function()
	--vim.lsp.buf.workspace_symbol()
	--end, bufnr, "workspace_symbol")
	--set_nkeymap("<leader>vd", function()
	--vim.diagnostic.open_float()
	--end, bufnr, "open_float")
	set_nkeymap("<leader>vdn", function()
		vim.diagnostic.goto_next()
	end, bufnr, "goto_next")
	set_nkeymap("<leader>vdp", function()
		vim.diagnostic.goto_prev()
	end, bufnr, "goto_prev")
	set_nkeymap("<leader>vca", function()
		vim.lsp.buf.code_action()
	end, bufnr, "code_action")
	set_nkeymap("<leader>vrr", function()
		vim.lsp.buf.references()
	end, bufnr, "references")
	set_nkeymap("<leader>vrn", function()
		vim.lsp.buf.rename()
	end, bufnr, "rename")
	--set_nkeymap("<C-h>", function()
	--vim.lsp.buf.signature_help()
	--end, bufnr, "signature_help")

	local mappings = {
		["<leader>v"] = { name = "+lsp" },
		["<leader>vw"] = { name = "workspace" },
		["<leader>vc"] = { name = "code" },
		["<leader>vd"] = { name = "+diagnostic" },
		["<leader>vr"] = { name = "misc" },
	}
	require("which-key").register(mappings)
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
		--"vimls", --vim scripts
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
					pyright = {
						disableOrganizeImports = false,
					},
					python = {
						analysis = {
							autoImportCompletions = true,
							diagnosticMode = "workspace",
							--extraPaths = "",
							typeCheckingMode = "basic",
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
