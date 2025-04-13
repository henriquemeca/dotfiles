-- Cmp config
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { vim.fn.stdpath("config") .. "/snippets" },
})
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
		{ name = "snippets" },
		{ name = "vim-snippets" },
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

-- default settings
require("scissors").setup({
	snippetDir = vim.fn.stdpath("config") .. "/snippets",
	editSnippetPopup = {
		height = 0.4, -- relative to the window, between 0-1
		width = 0.6,
		--border = getBorder(), -- `vim.o.winborder` on nvim 0.11, otherwise "rounded"
		keymaps = {
			-- if not mentioned otherwise, the keymaps apply to normal mode
			cancel = "q",
			saveChanges = "<CR>", -- alternatively, can also use `:w`
			goBackToSearch = "<BS>",
			deleteSnippet = "<C-BS>",
			duplicateSnippet = "<C-d>",
			openInFile = "<C-o>",
			insertNextPlaceholder = "<C-p>", -- insert & normal mode
			showHelp = "?",
		},
	},

	snippetSelection = {
		picker = "auto", ---@type "auto"|"telescope"|"snacks"|"vim.ui.select"

		telescope = {
			-- By default, the query only searches snippet prefixes. Set this to
			-- `true` to also search the body of the snippets.
			alsoSearchSnippetBody = false,

			-- accepts the common telescope picker config
			opts = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = { width = 0.9 },
					preview_width = 0.6,
				},
			},
		},

		-- `snacks` picker configurable via snacks config,
		-- see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
	},

	-- `none` writes as a minified json file using `vim.encode.json`.
	-- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
	-- you version control your snippets. To use a custom formatter, set to a
	-- list of strings, which will then be passed to `vim.system()`.
	---@type "yq"|"jq"|"none"|string[]
	jsonFormatter = "none",

	backdrop = {
		enabled = true,
		blend = 50, -- between 0-100
	},
	icons = {
		scissors = "󰩫",
	},
})

VKSN("<leader>me", function()
	require("scissors").editSnippet()
end, "edit snippet")

vim.keymap.set({ "v", "n", "x" }, "<leader>ma", function()
	require("scissors").addNewSnippet()
end, { desc = "add snippet" })
