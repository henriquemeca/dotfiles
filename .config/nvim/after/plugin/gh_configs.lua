require("gh-actions").setup({
	--- The browser executable path to open workflow runs/jobs in
	---@type string|nil
	browser = nil,
	--- Interval to refresh in seconds
	refresh_interval = 10,
	--- How much workflow runs and jobs should be indented
	indent = 2,
	icons = {
		workflow_dispatch = "⚡️",
		conclusion = {
			success = "✓",
			failure = "X",
			startup_failure = "X",
			cancelled = "⊘",
			skipped = "◌",
		},
		status = {
			unknown = "?",
			pending = "○",
			queued = "○",
			requested = "○",
			waiting = "○",
			in_progress = "●",
		},
	},
	highlights = {
		GhActionsRunIconSuccess = { link = "LspDiagnosticsVirtualTextHint" },
		GhActionsRunIconFailure = { link = "LspDiagnosticsVirtualTextError" },
		GhActionsRunIconStartup_failure = { link = "LspDiagnosticsVirtualTextError" },
		GhActionsRunIconPending = { link = "LspDiagnosticsVirtualTextWarning" },
		GhActionsRunIconRequested = { link = "LspDiagnosticsVirtualTextWarning" },
		GhActionsRunIconWaiting = { link = "LspDiagnosticsVirtualTextWarning" },
		GhActionsRunIconIn_progress = { link = "LspDiagnosticsVirtualTextWarning" },
		GhActionsRunIconCancelled = { link = "Comment" },
		GhActionsRunIconSkipped = { link = "Comment" },
		GhActionsRunCancelled = { link = "Comment" },
		GhActionsRunSkipped = { link = "Comment" },
		GhActionsJobCancelled = { link = "Comment" },
		GhActionsJobSkipped = { link = "Comment" },
		GhActionsStepCancelled = { link = "Comment" },
		GhActionsStepSkipped = { link = "Comment" },
	},
	split = {
		relative = "editor",
		position = "right",
		size = 60,
		win_options = {
			wrap = false,
			number = false,
			foldlevel = nil,
			foldcolumn = "0",
			cursorcolumn = false,
			signcolumn = "no",
		},
	},
})

-- Git commands

WHICH_KEY({
	g = {
		name = "git",
		s = { vim.cmd.Git, "status" },
		a = {
			name = "add",
			a = { ":Git add .<CR>", "add ." },
			f = { ":Git add ", "add - specific files" },
		},
		A = { "<cmd>GhActions<CR>", "Actions" }, -- gw (Workflow definition) gr (Workflow Run) d (Dispatch)
		c = {
			name = "commit/checkout",
			m = { ":Git commit ", "commit - page message" },
			c = { ":Git commit -m ''<Left>", "commit - short message" },
			a = { ":Git commit --amend --no-edit<CR>", "commit ammend" },
			o = { ":Git checkout ", "checkout" },
			O = { ":Git checkout origin/main", "checkout origin " },
			b = { ":Git checkout -b ", "checkout origin " },
			f = {
				function()
					vim.cmd("Git stash")
					vim.cmd("Git fetch")
					vim.cmd("Git checkout main")
					vim.cmd("Git reset --hard origin/main")
				end,
				"Force sync with main",
			},
		},
		p = {
			name = "push/pull",
			s = { ":Git push<CR>", "push" },
			l = { ":Git pull<CR>", "pull" },
		},
		x = { ":Git clean -f ", "clean" },
		t = { ":Git stash<CR>", "Stash" },
		T = { ":Git stash pop <CR>", "Stash Pop" },

		-- Git tools
		o = { ":GBrowse<CR>", "Open on Browser" },
		b = { ":Git blame<CR>", "Git blame" },
		d = { ":DiffviewOpen<CR>", "Open Diffview Tool" },
		D = { ":DiffviewOpen origin/main...HEAD<CR>", "Open Diffview Tool - origin/main<>HEAD" },
		m = {
			function()
				vim.cmd("Git fetch")
				vim.cmd("Git merge origin/main -m 'merge with main' --no-ff")
			end,
			"Fetches and merges origin/main",
		},
		h = { ":DiffviewFileHistory<CR>", "Git History - Diffview" },
		f = { ":DiffviewFileHistory %<CR>", "File Git History - Diffview" },
		l = { "<cmd>LazyGit<cr>", "Open Lazygit" },
		r = {
			function()
				vim.cmd("Git stash")
				vim.cmd("Git fetch")
				vim.cmd("Git rebase origin/main")
				vim.cmd("Git rebase --continue")
			end,
			"Rebase with main origin/main",
		},
		R = {
			function()
				vim.cmd("Git stash")
				vim.cmd("Git fetch")
				vim.cmd("Git reset --hard @{u}")
			end,
			"Fetches and resets origin/main",
		},
		w = {
			name = "Worktree",
			a = {
				":Git worktree add ../" .. os.capture("basename `git rev-parse --show-toplevel`") .. "_main " .. "main",
				"Create worktree",
			},
			b = {
				":Git worktree add -b "
					.. "new-branch ../"
					.. os.capture("basename `git rev-parse --show-toplevel`")
					.. "_main",
				"Create worktree in new branch",
			},
			l = { ":Git worktree list<CR>", "List worktrees" },
			d = {
				":Git worktree remove " .. os.capture("basename `git rev-parse --show-toplevel`") .. "_main",
				"Delete worktree",
			},
		},
	},
}, { prefix = "<leader>" })
