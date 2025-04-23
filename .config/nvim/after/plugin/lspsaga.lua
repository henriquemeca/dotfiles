require("lspsaga").setup({
	ui = {
		border = "rounded",
		devicon = true,
		foldericon = true,
		title = true,
		expand = "⊞",
		collapse = "⊟",
		code_action = "💡",
		actionfix = " ",
		lines = { "┗", "┣", "┃", "━", "┏" },
		kind = nil,
		imp_sign = "󰳛 ",
	},
	hover = {
		max_width = 0.9,
		max_height = 0.8,
		open_link = "gx",
		open_cmd = "!chrome",
	},
	diagnostic = {
		show_code_action = true,
		show_layout = "float",
		show_normal_height = 10,
		jump_num_shortcut = true,
		max_width = 0.8,
		max_height = 0.6,
		max_show_width = 0.9,
		max_show_height = 0.6,
		text_hl_follow = true,
		border_follow = true,
		wrap_long_lines = true,
		extend_relatedInformation = false,
		diagnostic_only_current = false,
		keys = {
			exec_action = "o",
			quit = "q",
			toggle_or_jump = "<CR>",
			quit_in_show = { "q", "<ESC>" },
		},
	},
	code_action = {
		num_shortcut = true,
		show_server_name = false,
		extend_gitsigns = true,
		only_in_cursor = true,
		max_height = 0.3,
		keys = {
			quit = "q",
			exec = "<CR>",
		},
	},
	lightbulb = {
		enable = false, -- deactivated
		sign = true,
		debounce = 10,
		sign_priority = 40,
		virtual_text = true,
		enable_in_insert = true,
	},
	scroll_preview = {
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
	request_timeout = 2000,
	finder = {
		max_height = 0.9,
		left_width = 0.5,
		methods = {},
		default = "def+ref+imp",
		layout = "float",
		silent = false,
		filter = {},
		fname_sub = nil,
		sp_inexist = false,
		sp_global = false,
		ly_botright = false,
		keys = {
			shuttle = "[w",
			toggle_or_open = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = "q",
			close = "<C-c>k",
		},
	},
	definition = {
		width = 0.6,
		height = 0.5,
		save_pos = false,
		keys = {
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>i",
			tabe = "<C-c>t",
			tabnew = "<C-c>n",
			quit = "q",
			close = "<C-c>k",
		},
	},
	rename = {
		in_select = true,
		auto_save = false,
		project_max_width = 0.5,
		project_max_height = 0.5,
		keys = {
			quit = "<C-q>",
			exec = "<CR>",
			select = "x",
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = false,
		ignore_patterns = nil,
		show_file = true,
		folder_level = 1,
		color_mode = true,
		dely = 300,
	},
	outline = {
		win_position = "right",
		win_width = 30,
		auto_preview = true,
		detail = true,
		auto_close = true,
		close_after_jump = false,
		layout = "normal",
		max_height = 0.5,
		left_width = 0.3,
		keys = {
			toggle_or_jump = "o",
			quit = "q",
			jump = "e",
		},
	},
	callhierarchy = {
		layout = "float",
		left_width = 0.2,
		keys = {
			edit = "e",
			vsplit = "s",
			split = "i",
			tabe = "t",
			close = "<C-q>",
			quit = "q",
			shuttle = "[w",
			toggle_or_req = "u",
		},
	},
	implement = {
		enable = false,
		sign = true,
		lang = {},
		virtual_text = true,
		priority = 100,
	},
	beacon = {
		enable = true,
		frequency = 7,
	},
	floaterm = {
		height = 0.7,
		width = 0.7,
	},
})

local function goto_definition_with_telescope()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, ctx, _)
		if not result or vim.tbl_isempty(result) then
			print("No definition found")
			return
		end

		-- If only one definition exists, jump directly
		if #result == 1 then
			vim.lsp.util.jump_to_location(result[1])
			return
		end

		vim.cmd("Telescope lsp_definitions")
	end)
end

--diagnostic
VKSN("[d", function()
	vim.cmd("Lspsaga diagnostic_jump_next")
end, "Diagnostic jump next")
VKSN("]d", function()
	vim.cmd("Lspsaga diagnostic_jump_prev")
end, "Diagnostic jump previous")
VKSN("K", function()
	vim.cmd("Lspsaga hover_doc")
end, "Hover doc")
VKSN("gd", function()
	goto_definition_with_telescope()
	FEEDKEYS("zz")
end, "Go to definition")
VKSN("gD", function()
	vim.cmd("vsplit")
	--vim.cmd("Telescope lsp_definitions")
	goto_definition_with_telescope()
	FEEDKEYS("zz")
end, "Go to definition - Split view")

WHICH_KEY({
	l = {
		name = "+Lsp Navigator",
		f = {
			function()
				vim.cmd("Lspsaga finder")
			end,
			"Finder",
		},
		a = {
			function()
				vim.cmd("Lspsaga code_action")
			end,
			"Code Actions",
		},
		d = {
			function()
				vim.lsp.buf.definition() --vim.cmd("Lspsaga goto_definition")
				FEEDKEYS("zz")
			end,
			"Go to definition",
		},
		D = {
			function()
				vim.cmd("vsplit")
				vim.lsp.buf.definition() --vim.cmd("Lspsaga goto_definition")
				FEEDKEYS("zz")
			end,
			"Go to type definition",
		},
		p = {
			function()
				vim.cmd("Lspsaga peek_definition")
			end,
			"Peek definition",
		},
		P = {
			function()
				vim.cmd("Lspsaga peek_type_definition")
			end,
			"Peek type definition",
		},
		r = {
			function()
				vim.cmd("Lspsaga rename")
			end,
			"Rename",
		},
		o = {
			function()
				vim.cmd("Lspsaga outline")
			end,
			"Outline",
		},
		m = {
			function()
				vim.diagnostic.disable()
			end,
			"Disable diagnostic",
		},
		n = {
			function()
				vim.diagnostic.enable()
			end,
			"Enable diagnostic",
		},
		c = {
			name = "Call Hierarchy",
			i = {
				function()
					vim.cmd("Lspsaga incoming_calls")
				end,
				"Incoming calls",
			},
			o = {
				function()
					vim.cmd("Lspsaga outgoing_calls")
				end,
				"Outcoming calls",
			},
		},
	},
}, { prefix = "<leader>" })
