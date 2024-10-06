-- deps:
require("img-clip").setup({
	embed_image_as_base64 = false,
	prompt_for_file_name = false,
	drag_and_drop = {
		insert_mode = true,
	},
})
require("avante_lib").load()
require("avante").setup({
	--@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
	provider = "copilot", -- Recommend using Claude
	auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
	--openai = {
	--endpoint = "https://api.openai.com/v1",
	--model = "gpt-4o",
	--timeout = 30000, -- Timeout in milliseconds
	--temperature = 0,
	--max_tokens = 4096,
	--["local"] = false,
	--},
	--@type AvanteSupportedProvider
	copilot = {
		endpoint = "https://api.githubcopilot.com",
		model = "gpt-4o-2024-05-13",
		proxy = nil, -- [protocol://]host[:port] Use this proxy
		allow_insecure = false, -- Allow insecure server connections
		timeout = 30000, -- Timeout in milliseconds
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
		ask = "<leader>va",
		edit = "<leader>ve",
		refresh = "<leader>vr",
		toggle = {
			default = "<leader>vt",
			debug = "<leader>vd",
			hint = "<leader>vh",
			suggestion = "<leader>vs",
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
		--@type AvanteConflictHighlights
		diff = {
			current = "DiffText",
			incoming = "DiffAdd",
		},
	},
	--- @class AvanteConflictUserConfig
	diff = {
		autojump = true,
		---@type string | fun(): any
		list_opener = "copen",
	},
})
