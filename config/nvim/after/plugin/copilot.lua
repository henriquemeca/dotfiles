local copilot = require("copilot")
copilot.setup({
	panel = {
		enabled = true,
		auto_refresh = true,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-CR>",
		},
		layout = {
			position = "bottom", -- | top | left | right
			ratio = 0.4,
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<M-l>",
			accept_word = false,
			accept_line = false,
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["*"] = true,
	},
	copilot_node_command = "node", -- Node.js version must be > 18.x
	server_opts_overrides = {
		trace = "verbose",
		settings = {
			advanced = {
				listCount = 10, -- #completions for panel
				inlineSuggestCount = 5, -- #completions for getCompletions
			},
		},
	},
})

WHICH_KEY({
	X = {
		name = "Copilot",
		a = { "<cmd>Copilot panel accept<cr>", "Copilot Accept" },
		n = { "<cmd>Copilot panel jump_next<cr>", "Copilot Jump Next" },
		p = { "<cmd>Copilot panel jump_prev<cr>", "Copilot Jump Prev" },
		o = { "<cmd>Copilot panel open<cr>", "Copilot Open" },
		R = { "<cmd>Copilot panel refresh<cr>", "Copilot Refresh" },
		s = { "<cmd>Copilot status<cr>", "Copilot Refresh" },
		P = { "<cmd>Copilot Panel<cr>", "Copilot Status" },
	},
}, { prefix = "<leader>" })
WHICH_KEY({
	["<C-d>"] = { "<cmd>Copilot suggestion accept<cr>", "Copilot Accept" },
	["<C-f>"] = { "<cmd>Copilot suggestion accept_line<cr>", "Accept Line" },
	["<C-F>"] = { "<cmd>Copilot suggestion accept_word<cr>", "Accept Word" },
	["<C-g>"] = { "<cmd>Copilot suggestion next<cr>", "Next" },
	["<C-G>"] = { "<cmd>Copilot suggestion prev<cr>", "Prev" },
	["<C-e>"] = { "<cmd>Copilot suggestion dismiss<cr>", "Dismiss" },
	["<C-E>"] = { "<cmd>Copilot suggestion toggle_auto_trigger<cr>", "Toggle Auto Trigger" },
}, { mode = "i" })
