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
			s = {
				function()
					vim.cmd("Git fetch")
					vim.cmd("Git merge origin/main -m 'merged with main' --no-ff")
				end,
				"Sync branch with main",
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
	},
}, { prefix = "<leader>" })
