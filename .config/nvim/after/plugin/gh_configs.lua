--require("gh-actions").setup({
----- The browser executable path to open workflow runs/jobs in
-----@type string|nil
--browser = nil,
----- Interval to refresh in seconds
--refresh_interval = 10,
----- How much workflow runs and jobs should be indented
--indent = 2,
--icons = {
--workflow_dispatch = "⚡️",
--conclusion = {
--success = "✓",
--failure = "X",
--startup_failure = "X",
--cancelled = "⊘",
--skipped = "◌",
--},
--status = {
--unknown = "?",
--pending = "○",
--queued = "○",
--requested = "○",
--waiting = "○",
--in_progress = "●",
--},
--},
--highlights = {
--GhActionsRunIconSuccess = { link = "LspDiagnosticsVirtualTextHint" },
--GhActionsRunIconFailure = { link = "LspDiagnosticsVirtualTextError" },
--GhActionsRunIconStartup_failure = { link = "LspDiagnosticsVirtualTextError" },
--GhActionsRunIconPending = { link = "LspDiagnosticsVirtualTextWarning" },
--GhActionsRunIconRequested = { link = "LspDiagnosticsVirtualTextWarning" },
--GhActionsRunIconWaiting = { link = "LspDiagnosticsVirtualTextWarning" },
--GhActionsRunIconIn_progress = { link = "LspDiagnosticsVirtualTextWarning" },
--GhActionsRunIconCancelled = { link = "Comment" },
--GhActionsRunIconSkipped = { link = "Comment" },
--GhActionsRunCancelled = { link = "Comment" },
--GhActionsRunSkipped = { link = "Comment" },
--GhActionsJobCancelled = { link = "Comment" },
--GhActionsJobSkipped = { link = "Comment" },
--GhActionsStepCancelled = { link = "Comment" },
--GhActionsStepSkipped = { link = "Comment" },
--},
--split = {
--relative = "editor",
--position = "right",
--size = 60,
--win_options = {
--wrap = false,
--number = false,
--foldlevel = nil,
--foldcolumn = "0",
--cursorcolumn = false,
--signcolumn = "no",
--},
--},
--})

-- Git commands

local default_branch = nil

local function get_default_branch()
	if default_branch then
		return default_branch
	end
	-- Get the default branch dynamically
	local handle = io.popen("git remote show origin | grep 'HEAD branch' | awk '{print $NF}'")
	if handle then
		default_branch = handle:read("*l")
		handle:close()
	end
	return default_branch or "main" -- Fallback to 'main' if detection fails
end

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
			O = {
				function()
					vim.cmd("Git checkout origin/" .. get_default_branch())
				end,
				"checkout origin ",
			},
			b = { ":Git checkout -b ", "checkout origin " },
			f = {
				function()
					local branch = get_default_branch()
					vim.cmd("Git stash")
					vim.cmd("Git fetch")
					vim.cmd("Git checkout " .. branch)
					vim.cmd("Git reset --hard origin/" .. branch)
				end,
				"Force sync with default branch",
			},
		},
		p = {
			name = "push/pull",
			s = { ":Git push<CR>", "push" },
			l = {

				function()
					vim.cmd("Git fetch")
					vim.cmd("Git pull")
				end,
				"pull",
			},
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
			"Fetches and merges origin/ default branch",
		},
		h = { ":DiffviewFileHistory<CR>", "Git History - Diffview" },
		f = { ":DiffviewFileHistory %<CR>", "File Git History - Diffview" },
		l = { "<cmd>LazyGit<cr>", "Open Lazygit" },
		r = {
			function()
				vim.cmd("Git stash")
				vim.cmd("Git fetch")
				vim.cmd("Git rebase origin/" .. get_default_branch())
				vim.cmd("Git rebase --continue")
			end,
			"Rebase with origin/main origin",
		},
		R = {
			function()
				vim.cmd("Git stash")
				vim.cmd("Git fetch")
				vim.cmd("Git reset --hard @{u}")
			end,
			"Fetches and resets origin/{branch}",
		},
		w = {
			name = "Worktree",
			a = {
				function()
					vim.cmd(
						":Git worktree add ../"
							.. os.capture("basename `git rev-parse --show-toplevel`")
							.. "_main "
							.. get_default_branch()
					)
				end,
				"Create worktree",
			},
			b = {
				function()
					vim.cmd(
						":Git worktree add -b "
							.. "new-branch ../"
							.. os.capture("basename `git rev-parse --show-toplevel`")
							.. "_"
							.. get_default_branch()
					)
				end,
				"Create worktree in new branch",
			},
			l = { ":Git worktree list<CR>", "List worktrees" },
			d = {
				function()
					vim.cmd(
						":Git worktree remove "
							.. os.capture("basename `git rev-parse --show-toplevel`")
							.. "_"
							.. get_default_branch()
					)
				end,
				"Delete worktree",
			},
		},
	},
}, { prefix = "<leader>" })
