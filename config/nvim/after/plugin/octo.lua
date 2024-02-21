local remappings = {
	issue = {
		close_issue = { lhs = "<leader>oiic", desc = "close issue" },
		reopen_issue = { lhs = "<leader>oiio", desc = "reopen issue" },
		list_issues = { lhs = "<leader>oiil", desc = "list open issues on same repo" },
		reload = { lhs = "<leader>R", desc = "reload issue" },
		open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
		copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
		add_assignee = { lhs = "<leader>oiaa", desc = "add assignee" },
		remove_assignee = { lhs = "<leader>oiad", desc = "remove assignee" },
		create_label = { lhs = "<leader>oilc", desc = "create label" },
		add_label = { lhs = "<leader>oila", desc = "add label" },
		remove_label = { lhs = "<leader>oild", desc = "remove label" },
		goto_issue = { lhs = "<leader>oig", desc = "navigate to a local repo issue" },
		add_comment = { lhs = "<leader>oica", desc = "add comment" },
		delete_comment = { lhs = "<leader>oicd", desc = "delete comment" },
		next_comment = { lhs = "]c", desc = "go to next comment" },
		prev_comment = { lhs = "[c", desc = "go to previous comment" },
		react_hooray = { lhs = "<leader>oirp", desc = "add/remove 🎉 reaction" },
		react_heart = { lhs = "<leader>oirh", desc = "add/remove ❤️ reaction" },
		react_eyes = { lhs = "<leader>oire", desc = "add/remove 👀 reaction" },
		react_thumbs_up = { lhs = "<leader>oir+", desc = "add/remove 👍 reaction" },
		react_thumbs_down = { lhs = "<leader>oir-", desc = "add/remove 👎 reaction" },
		react_rocket = { lhs = "<leader>oirr", desc = "add/remove 🚀 reaction" },
		react_laugh = { lhs = "<leader>oirl", desc = "add/remove 😄 reaction" },
		react_confused = { lhs = "<leader>oirc", desc = "add/remove 😕 reaction" },
	},
	pull_request = {
		checkout_pr = { lhs = "<leader>opc", desc = "checkout PR" },
		merge_pr = { lhs = "<leader>opm", desc = "merge commit PR" },
		squash_and_merge_pr = { lhs = "<leader>opM", desc = "squash and merge PR" },
		list_commits = { lhs = "<leader>opc", desc = "list PR commits" },
		list_changed_files = { lhs = "<leader>opf", desc = "list PR changed files" },
		show_pr_diff = { lhs = "<leader>opd", desc = "show PR diff" },
		add_reviewer = { lhs = "<leader>opva", desc = "add reviewer" },
		remove_reviewer = { lhs = "<leader>opvd", desc = "remove reviewer request" },
		close_issue = { lhs = "<leader>opic", desc = "close PR" },
		reopen_issue = { lhs = "<leader>opio", desc = "reopen PR" },
		list_issues = { lhs = "<leader>opil", desc = "list open issues on same repo" },
		reload = { lhs = "<leader>R", desc = "reload PR" },
		open_in_browser = { lhs = "<leader>opb", desc = "open PR in browser" },
		copy_url = { lhs = "<leader>opu", desc = "copy url to system clipboard" },
		goto_file = { lhs = "gf", desc = "go to file" },
		add_assignee = { lhs = "<leader>opaa", desc = "add assignee" },
		remove_assignee = { lhs = "<leader>opad", desc = "remove as ssignee" },
		create_label = { lhs = "<leader>oplc", desc = "create label" },
		add_label = { lhs = "<leader>opla", desc = "add label" },
		remove_label = { lhs = "<leader>opld", desc = "remove label" },
		goto_issue = { lhs = "<leader>opg", desc = "navigate to a local repo issue" },
		add_comment = { lhs = "<leader>opca", desc = "add comment" },
		delete_comment = { lhs = "<leader>opcd", desc = "delete comment" },
		next_comment = { lhs = "]c", desc = "go to next comment" },
		prev_comment = { lhs = "[c", desc = "go to previous comment" },
		react_hooray = { lhs = "<leader>oprp", desc = "add/remove 🎉 reaction" },
		react_heart = { lhs = "<leader>oprh", desc = "add/remove ❤️ reaction" },
		react_eyes = { lhs = "<leader>opre", desc = "add/remove 👀 reaction" },
		react_thumbs_up = { lhs = "<leader>opr+", desc = "add/remove 👍 reaction" },
		react_thumbs_down = { lhs = "<leader>opr-", desc = "add/remove 👎 reaction" },
		react_rocket = { lhs = "<leader>oprr", desc = "add/remove 🚀 reaction" },
		react_laugh = { lhs = "<leader>oprl", desc = "add/remove 😄 reaction" },
		react_confused = { lhs = "<leader>oprc", desc = "add/remove 😕 reaction" },
	},
	review_thread = {
		goto_issue = { lhs = "<leader>otg", desc = "navigate to a local repo issue" },
		add_comment = { lhs = "<leader>otca", desc = "add comment" },
		add_suggestion = { lhs = "<leader>otsa", desc = "add suggestion" },
		delete_comment = { lhs = "<leader>otcd", desc = "delete comment" },
		next_comment = { lhs = "]c", desc = "go to next comment" },
		prev_comment = { lhs = "[c", desc = "go to previous comment" },
		--select_next_entry = { lhs = "]f", desc = "move to previous changed file" },
		--select_prev_entry = { lhs = "[f", desc = "move to next changed file" },
		--select_first_entry = { lhs = "[F", desc = "move to first changed file" },
		--select_last_entry = { lhs = "]F", desc = "move to last changed file" },
		close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
		react_hooray = { lhs = "<leader>otrp", desc = "add/remove 🎉 reaction" },
		react_heart = { lhs = "<leader>otrh", desc = "add/remove ❤️ reaction" },
		react_eyes = { lhs = "<leader>otre", desc = "add/remove 👀 reaction" },
		react_thumbs_up = { lhs = "<leader>otr+", desc = "add/remove 👍 reaction" },
		react_thumbs_down = { lhs = "<leader>otr-", desc = "add/remove 👎 reaction" },
		react_rocket = { lhs = "<leader>otrr", desc = "add/remove 🚀 reaction" },
		react_laugh = { lhs = "<leader>otrl", desc = "add/remove 😄 reaction" },
		react_confused = { lhs = "<leader>otrc", desc = "add/remove 😕 reaction" },
	},
	submit_win = {
		approve_review = { lhs = "<C-a>", desc = "approve review" },
		comment_review = { lhs = "<C-m>", desc = "comment review" },
		request_changes = { lhs = "<C-r>", desc = "request changes review" },
		close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
	},
	review_diff = {
		add_review_comment = { lhs = "<leader>oca", desc = "add a new review comment" },
		--add_review_suggestion = { lhs = "<leader>ocs", desc = "add a new review suggestion" },
		focus_files = { lhs = "<leader>b", desc = "move focus to changed file panel" },
		toggle_files = { lhs = "<leader>B", desc = "hide/show changed files panel" },
		next_thread = { lhs = "]t", desc = "move to next thread" },
		prev_thread = { lhs = "[t", desc = "move to previous thread" },
		--select_next_entry = { lhs = "]f", desc = "move to previous changed file" },
		--select_prev_entry = { lhs = "[f", desc = "move to next changed file" },
		--select_first_entry = { lhs = "[F", desc = "move to first changed file" },
		--select_last_entry = { lhs = "]F", desc = "move to last changed file" },
		close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
		toggle_viewed = { lhs = "<leader>v", desc = "toggle viewer viewed state" },
		goto_file = { lhs = "gf", desc = "go to file" },
	},
	file_panel = {
		next_entry = { lhs = "j", desc = "move to next changed file" },
		prev_entry = { lhs = "k", desc = "move to previous changed file" },
		select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
		refresh_files = { lhs = "R", desc = "refresh changed files panel" },
		focus_files = { lhs = "<leader>b", desc = "move focus to changed file panel" },
		toggle_files = { lhs = "<leader>B", desc = "hide/show changed files panel" },
		--select_next_entry = { lhs ="]f", desc = "move to previous changed file" },
		--select_prev_entry = { lhs = "[f", desc = "move to next changed file" },
		--select_first_entry = { lhs = "[F", desc = "move to first changed file" },
		--select_last_entry = { lhs = "]F", desc = "move to last changed file" },
		close_review_tab = { lhs = "<c-c>", desc = "close review tab" },
		toggle_viewed = { lhs = "<leader>v", desc = "toggle viewer viewed state" },
	},
}

--- Read the key mapping from octo.nvim
--- then convert it to flat table which sutable for display in Telescope
local function flat(mappings)
	local flatted = {}
	-- loop through all the mappings
	for topic, commands in pairs(mappings) do
		for func, command in pairs(commands) do
			table.insert(flatted, { topic = topic, func = func, lhs = command.lhs, desc = command.desc })
		end
	end

	return flatted
end

local flatted_mapping = flat(remappings)

require("octo").setup({
	use_local_fs = true, -- use local files on right side of reviews
	enable_builtin = true, -- shows a list of builtin actions when no action is provided
	default_remote = { "origin", "upstream" }, -- order to try remotes
	default_merge_method = "commit", -- default merge method which should be used when calling `Octo pr merge`, could be `commit`, `rebase` or `squash`
	ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
	picker = "telescope", -- or "fzf-lua"
	picker_config = {
		use_emojis = false, -- only used by "fzf-lua" picker for now
		mappings = { -- mappings for the pickers
			open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
			copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
			checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
			merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
		},
	},
	comment_icon = "▎", -- comment marker
	outdated_icon = "󰅒 ", -- outdated indicator
	resolved_icon = " ", -- resolved indicator
	reaction_viewer_hint_icon = " ", -- marker for user reactions
	user_icon = " ", -- user icon
	timeline_marker = " ", -- timeline marker
	timeline_indent = "2", -- timeline indentation
	right_bubble_delimiter = "", -- bubble delimiter
	left_bubble_delimiter = "", -- bubble delimiter
	github_hostname = "", -- GitHub Enterprise host
	snippet_context_lines = 4, -- number or lines around commented lines
	gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
	timeout = 5000, -- timeout for requests between the remote server
	default_to_projects_v2 = true, -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
	ui = {
		use_signcolumn = true, -- show "modified" marks on the sign column
	},
	issues = {
		order_by = { -- criteria to sort results of `Octo issue list`
			field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
			direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
		},
	},
	pull_requests = {
		order_by = { -- criteria to sort the results of `Octo pr list`
			field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
			direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
		},
		always_select_remote_on_create = false, -- always give prompt to select base remote repo when creating PRs
	},
	file_panel = {
		size = 10, -- changed files panel rows
		use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
	},
	colors = { -- used for highlight groups (see Colors section below)
		white = "#ffffff",
		grey = "#2A354C",
		black = "#000000",
		red = "#fdb8c0",
		dark_red = "#da3633",
		green = "#acf2bd",
		dark_green = "#238636",
		yellow = "#d3c846",
		dark_yellow = "#735c0f",
		blue = "#58A6FF",
		dark_blue = "#0366d6",
		purple = "#6f42c1",
	},
	mappings = remappings,
})
local octo_maps = require("octo.mappings")

-- Movements
WHICH_KEY({
	["]f"] = {
		function()
			octo_maps.select_next_entry()
			FEEDKEYS("<C-w>w")
		end,
		"Move to next file",
	},
	["[f"] = {
		function()
			octo_maps.select_prev_entry()
			FEEDKEYS("<C-w>w")
		end,
		"Move to previous file",
	},
	["]F"] = {
		function()
			octo_maps.select_last_entry()
			FEEDKEYS("<C-w>w")
		end,
		"Move to first file",
	},
	["[F"] = {
		function()
			octo_maps.select_first_entry()
			FEEDKEYS("<C-w>w")
		end,
		"Move to last file",
	},
})

WHICH_KEY({
	["<leader>oi"] = { name = "+Issue" },
	["<leader>oia"] = { name = "+assigne" },
	o = {
		name = "Octo",
		a = { "<cmd>Octo actions<cr>", "Show octo actions" },
		p = {
			name = "PR",
			l = { "<cmd>Octo pr list<cr>", "List PRs" },
			s = { "<cmd>Octo pr search<cr>", "Search PRs" },
			e = { "<cmd>Octo pr edit", "Open PR by number" },
			u = { "<cmd>Octo pr ", "Open PR by URL" },
			C = { "<cmd>Octo pr create<cr>", "Create PR" },
			i = { name = "+issue" },
			r = { name = "+reaction" },
			v = { name = "+viewer" },
			a = { name = "+assigne" },
		},
		t = {
			name = "Thread",
			r = { "<cmd>Octo thread resolve<cr>", "Thread resolve" },
			u = { "<cmd>Octo thread unresolve<cr>", "Thread unresolve" },
			c = { name = "+comment" },
			s = { name = "+sugestion" },
		},
		r = {
			name = "Review",
			s = { "<cmd>Octo review submit<cr><cmd>BlamerShow<cr>", "Submit a review" },
			d = { "<cmd>Octo review discard<cr><cmd>BlamerShow<cr>", "Discard review" },
			c = { "<cmd>Octo review close<cr><cmd>BlamerShow<cr>", "Close window review" },
			r = {
				function()
					if not pcall(vim.cmd("Octo review resume")) then
						vim.cmd("Octo review start")
					end
					vim.cmd("BlamerHide")
					FEEDKEYS("<C-w>w")
				end,
				"Start/Resume pending review",
			},
		},
		i = {
			name = "issues",
			a = { name = "+assigne" },
			c = { name = "+comment" },
			i = { name = "+issue" },
			l = { name = "+label" },
			r = { name = "+reaction" },
		},
	},
}, { prefix = "<leader>" })

-- Comments
local function custom_comment(map, keys, description)
	VKSN(map, function()
		octo_maps.add_review_comment()
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), "n")
	end, { desc = description })
end

local function custom_suggestion(map, keys, description)
	VKSN(map, function()
		octo_maps.add_review_suggestion()
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<ESC>kkko" .. keys, true, true, true), "n")
	end, { desc = description })
end

-- Question
custom_comment("<leader>ocq", "question:", "Add question comment")
custom_suggestion("<leader>ocQ", "question:", "Add question suggestion")
-- ToDo
custom_comment("<leader>oct", "toDo:", "Add toDo comment")
custom_suggestion("<leader>ocT", "toDo:", "Add toDo suggestion")
-- Suggestion
custom_suggestion("<leader>ocs", octo_maps.add_review_suggestion, "Add suggestion (only)")
custom_comment("<leader>ocg", "suggestion:", "Add suggestion comment")
custom_suggestion("<leader>ocG", "suggestion:", "Add 'suggestion' suggestion")
-- Prase
custom_comment("<leader>ocp", "praise:", "Add praise comment")
-- Thought
custom_comment("<leader>och", "thought:", "Add thought comment")
custom_suggestion("<leader>ocH", "thought:", "Add thought suggestion")
-- Note
custom_comment("<leader>ocn", "note:", "Add note comment")
custom_suggestion("<leader>ocN", "note:", "Add note suggestion")

for _, mapping in pairs(flatted_mapping) do
	WHICH_KEY({ [mapping.lhs] = { name = mapping.desc } })
end

-- Enforce which-key
WHICH_KEY({
	["<leader>opa"] = { name = "+assigne" },
	["<leader>opi"] = { name = "+issue" },
	["<leader>opr"] = { name = "+reaction" },
	["<leader>opv"] = { name = "+viewer" },
	["<leader>oc"] = { name = "+comment" },
	["<leader>otc"] = { name = "+comment" },
	["<leader>ots"] = { name = "+sugestion" },
	["<leader>oi"] = { name = "+Issue" },
	["<leader>oia"] = { name = "+assigne" },
	["<leader>oic"] = { name = "+comment" },
	["<leader>oii"] = { name = "+issue" },
	["<leader>oil"] = { name = "+label" },
	["<leader>oir"] = { name = "+reaction" },
})
