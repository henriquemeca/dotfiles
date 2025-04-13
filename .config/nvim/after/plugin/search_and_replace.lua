-- options : https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
require("grug-far").setup({
	-- options, see Configuration section below
	-- there are no required options atm
	engine = "ripgrep", -- is default, but 'astgrep' or 'astgrep-rules' can
	-- be specified
	keymaps = {
		replace = { n = "<localleader>r" },
		qflist = { n = "<localleader>q" },
		syncLocations = { n = "<localleader>s" },
		syncLine = { n = "<localleader>l" },
		close = { n = "<localleader>c" },
		historyOpen = { n = "<localleader>t" },
		historyAdd = { n = "<localleader>a" },
		refresh = { n = "<localleader>f" },
		openLocation = { n = "<localleader>o" },
		openNextLocation = { n = "<down>" },
		openPrevLocation = { n = "<up>" },
		gotoLocation = { n = "<enter>" },
		pickHistoryEntry = { n = "<enter>" },
		abort = { n = "<localleader>b" },
		help = { n = "g?" },
		toggleShowCommand = { n = "<localleader>w" },
		swapEngine = { n = "<localleader>e" },
		previewLocation = { n = "<localleader>i" },
		swapReplacementInterpreter = { n = "<localleader>x" },
		applyNext = { n = "<localleader>j" },
		applyPrev = { n = "<localleader>k" },
		syncNext = { n = "<localleader>n" },
		syncPrev = { n = "<localleader>p" },
		syncFile = { n = "<localleader>v" },
		nextInput = { n = "<tab>" },
		prevInput = { n = "<s-tab>" },
	},
})
WHICH_KEY({
	L = {
		name = "Search&Replace",
		w = {
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			"Seach Word",
		},
		s = {
			function()
				require("grug-far").open()
			end,
			"Seach Word",
		},
	},
}, { prefix = "<leader>" })

--vim.g.multi_cursor_use_default_mapping = 0
---- Default mapping
--vim.g.multi_cursor_start_word_key = "<C-n>"
--vim.g.multi_cursor_select_all_word_key = "<A-n>"
--vim.g.multi_cursor_start_key = "g<C-n>"
--vim.g.multi_cursor_select_all_key = "g<A-n>"
--vim.g.multi_cursor_next_key = "<C-n>"
--vim.g.multi_cursor_prev_key = "<C-p>"
--vim.g.multi_cursor_skip_key = "<C-x>"
--vim.g.multi_cursor_quit_key = "<Esc>"

--VKSV("<C-i>", function()
--FEEDKEYS(":MultipleCursorsFind ^<CR>")
--end)
