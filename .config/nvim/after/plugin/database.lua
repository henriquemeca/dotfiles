vim.g.db_ui_use_nerd_fonts = 1
WHICH_KEY({
	b = {
		name = "DBUI",
		t = {
			function()
				vim.cmd("DBUIToggle")
			end,
			"Toggle",
		},
		a = {
			function()
				vim.cmd("DBUIAddConnection")
			end,
			"Add connection",
		},
		f = {
			function()
				vim.cmd("DBUIFindBuffer")
			end,
			"Find Buffer",
		},
		r = {
			function()
				vim.cmd("DBUIRenameBuffer")
			end,
			"Rename Buffer",
		},
		l = {
			function()
				vim.cmd("DBUILastQueryInfo")
			end,
			"Last Query Info",
		},
		n = {
			function()
				vim.cmd("DBUIHideNotifications")
			end,
			"Hide Notifications",
		},
	},
}, { prefix = "<leader>" })
