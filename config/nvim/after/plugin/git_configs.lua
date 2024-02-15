-- Git commands
VKSN("<leader>gcf", function()
	vim.cmd("Git stash")
	vim.cmd("Git fecth")
	vim.cmd("Git checkout main")
	vim.cmd("Git reset --hard origin/main")
end, { desc = "Force sync with main" })

WHICH_KEY({
	g = {
		name = "git",
		s = { vim.cmd.Git, "git status" },
		a = {
			name = "add",
			a = { ":Git add .<CR>", "git add ." },
			f = { ":Git add ", "git add - specific files" },
		},
		cc = { ":Git commit -m ''<Left>", "git commit - short message" },
		c = {
			name = "commit/checkout",
			m = { ":Git commit ", "git commit - page message" },
			a = { ":Git commit --amend --no-edit<CR>", "git commit ammend" },
			o = { ":Git checkout ", "git checkout" },
			O = { ":Git checkout origin/", "git checkout origin " },
		},
		p = {
			name = "push/pull",
			s = { ":Git push<CR>", "git push" },
			l = { ":Git pull<CR>", "git pull" },
		},
		x = { ":Git clean -f ", "git clean" },

		-- Git tools
		o = { ":GBrowse<CR>", "Open on Browser" },
		b = { ":Git blame<CR>", "Git blame" },
		d = { ":DiffviewOpen<CR>", "Open Diffview Tool" },
		D = { ":DiffviewOpen origin/", "Open Diffview Tool on commit" },
		m = { ":Git mergetool<CR>", "Git Merge Tool" },
		h = { ":DiffviewFileHistory<CR>", "Git History - Diffview" },
		f = { ":DiffviewFileHistory %<CR>", "File Git History - Diffview" },
		l = { "<cmd>LazyGit<cr>", "Open Lazygit" },
	},
}, { prefix = "<leader>" })
