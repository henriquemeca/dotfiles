require("chatgpt").setup({
	api_key_cmd = nil,
	yank_register = "+",
	edit_with_instructions = {
		diff = false,
		keymaps = {
			close = "<C-c>",
			accept = "<C-y>",
			toggle_diff = "<C-d>",
			toggle_settings = "<C-o>",
			toggle_help = "<C-h>",
			cycle_windows = "<Tab>",
			use_output_as_input = "<C-i>",
		},
	},
	chat = {
		welcome_message = "Welcome ",
		loading_text = "Loding, please wait ...",
		question_sign = "", -- 🙂
		answer_sign = "ﮧ", -- 🤖
		border_left_sign = "",
		border_right_sign = "",
		max_line_length = 120,
		sessions_window = {
			active_sign = "  ",
			inactive_sign = "  ",
			current_line_sign = "",
			border = {
				style = "rounded",
				text = {
					top = " Sessions ",
				},
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
		keymaps = {
			close = "<C-c>",
			yank_last = "<C-y>",
			yank_last_code = "<C-k>",
			scroll_up = "<C-u>",
			scroll_down = "<C-d>",
			new_session = "<C-n>",
			cycle_windows = "<Tab>",
			cycle_modes = "<C-f>",
			next_message = "<C-j>",
			prev_message = "<C-k>",
			select_session = "<C-m>",
			rename_session = "<C-g>",
			delete_session = "d",
			draft_message = "<C-;>",
			edit_message = "e",
			delete_message = "d",
			toggle_settings = "<C-o>",
			toggle_sessions = "<C-p>",
			toggle_help = "<C-h>",
			toggle_message_role = "<C-r>",
			toggle_system_role_open = "<C-s>",
			stop_generating = "<C-x>",
		},
	},
	popup_layout = {
		default = "center",
		center = {
			width = "80%",
			height = "80%",
		},
		right = {
			width = "30%",
			width_settings_open = "50%",
		},
	},
	popup_window = {
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " ChatGPT ",
			},
		},
		win_options = {
			wrap = true,
			linebreak = true,
			foldcolumn = "1",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
		buf_options = {
			filetype = "markdown",
		},
	},
	system_window = {
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " SYSTEM ",
			},
		},
		win_options = {
			wrap = true,
			linebreak = true,
			foldcolumn = "2",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	popup_input = {
		prompt = "  ",
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top_align = "center",
				top = " Prompt ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
		submit = "<C-Enter>",
		submit_n = "<Enter>",
		max_visible_lines = 20,
	},
	settings_window = {
		setting_sign = "  ",
		border = {
			style = "rounded",
			text = {
				top = " Settings ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	help_window = {
		setting_sign = "  ",
		border = {
			style = "rounded",
			text = {
				top = " Help ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	openai_params = {
		model = "gpt-3.5-turbo",
		frequency_penalty = 0,
		presence_penalty = 0,
		max_tokens = 300,
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	openai_edit_params = {
		model = "gpt-3.5-turbo",
		frequency_penalty = 0,
		presence_penalty = 0,
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	use_openai_functions_for_edits = false,
	actions_paths = {},
	show_quickfixes_cmd = "Trouble quickfix",
	predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
	highlights = {
		help_key = "@symbol",
		help_description = "@comment",
	},
})

require("codecompanion").setup({
	---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
	provider = "openai", -- Recommend using Claude
	auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
	claude = {
		endpoint = "https://api.anthropic.com",
		model = "claude-3-5-sonnet-20240620",
		temperature = 0,
		max_tokens = 4096,
	},
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
	},
	mappings = {
		--- @class AvanteConflictMappings
		diff = {
			ours = "co",
			theirs = "ct",
			all_theirs = "ca",
			both = "cb",
			cursor = "cc",
			next = "]x",
			prev = "[x",
		},
		suggestion = {
			accept = "<M-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
		jump = {
			next = "]]",
			prev = "[[",
		},
		submit = {
			normal = "<CR>",
			insert = "<C-s>",
		},
		sidebar = {
			switch_windows = "<Tab>",
			reverse_switch_windows = "<S-Tab>",
		},
	},
	hints = { enabled = true },
	windows = {
		---@type "right" | "left" | "top" | "bottom"
		position = "right", -- the position of the sidebar
		wrap = true, -- similar to vim.o.wrap
		width = 30, -- default % based on available width
		sidebar_header = {
			align = "center", -- left, center, right for title
			rounded = true,
		},
	},
	highlights = {
		diff = {
			current = "DiffText",
			incoming = "DiffAdd",
		},
	},
	diff = {
		autojump = true,
		---@type string | fun(): any
		list_opener = "copen",
	},
})

WHICH_KEY({
	x = {
		name = "ChatGPT",
		c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
		a = { "<cmd>ChatGPTActAs<CR>", "ChatGPTActAs" },
		t = { "<cmd>CodeCompanionChat Toggle<CR>", "CodeCompanionChat" },
		d = { "<cmd>CodeCompanionChat add<CR>", "CodeCompanionChat add" },
		A = { "<cmd>CodeCompanionActions<CR>", "CodeCompanionActions" },
		e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
		r = {
			name = "ChatGpt Run",
			g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
			t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
			k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
			d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
			a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
			o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
			s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
			f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
			x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
			r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
			l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
		},
		x = { name = "Chat Window" },
	},
}, { prefix = "<leader>", mode = { "n", "v" } })
