local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, { buffer = bufnr, remap = false, desc = "hover" })
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, { buffer = bufnr, remap = false, desc = "workspace_symbol" })
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, { buffer = bufnr, remap = false, desc = "open_float" })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, { buffer = bufnr, remap = false, desc = "goto_next" })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, { buffer = bufnr, remap = false, desc = "goto_prev" })
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, { buffer = bufnr, remap = false, desc = "code_action" })
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, { buffer = bufnr, remap = false, desc = "references" })
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, { buffer = bufnr, remap = false, desc = "rename" })
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, { buffer = bufnr, remap = false, desc = "signature_help" })

	local mappings = {
		["<leader>v"] = { name = "+lsp" },
		["<leader>vw"] = { name = "workspace" },
		["<leader>vc"] = { name = "code" },
		["<leader>vr"] = { name = "misc" },
	}
	require("which-key").register(mappings)
end)

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
	settings = {
		efm = { -- example configuration for efm-langserver
			rootMarkers = { ".git/" },
			languages = {
				python = {
					{
						formatCommand = "black --quiet -",
						formatStdin = true, -- for black formatting
					},
					{
						LintCommand = "flake8 --stdin-display-name ${INPUT} -",
						lintStdin = true, -- for linting using flake8
						lintFormats = { "%f:%l:%c: %m" },
					},
				},
				sql = {
					{
						LintCommand = "sqlfluff lint -",
						lintStdin = true, -- for linting using sqlfluff
						lintFormats = { "%f:%l:%c: %m" },
					},
				},
			},
		},
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
			})
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})
