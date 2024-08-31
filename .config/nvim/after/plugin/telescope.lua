local builtin = require("telescope.builtin")
require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefi = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.4,
				--results_width = 0.3,
			},
			vertical = {
				mirror = false,
			},
			width = 0.99,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
	},

	extensions_list = { "themes", "terms" },
})

require("telescope").load_extension("live_grep_args")
require("neoclip").setup()

WHICH_KEY({
	f = {
		name = "Find",
		f = { "<cmd>Telescope find_files<cr>", "find files" },
		F = { "<c-w>v<cmd>Telescope find_files<cr>", "find files-new buffer" },
		s = { "<cmd>Telescope live_grep<cr>", "find string - working dir" },
		S = { "<c-w>v<cmd>Telescope live_grep<cr>", "find string-new buffer" },
		x = {
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
				FEEDKEYS('"" -t sql <Esc>_3li')
			end,
			"find string with args",
		},
		X = {
			function()
				vim.cmd("vs")
				require("telescope").extensions.live_grep_args.live_grep_args()
				FEEDKEYS('"" -t sql <Esc>_3li')
			end,
			"find string with args - new buffer",
		},
		c = { "<cmd>Telescope grep_string<cr>", "find string under cursor in current working directory" },
		b = { "<cmd>Telescope buffers<cr>", "buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "help tags" },
		t = { "<cmd>Telescope jumplist<cr>", "Open jumplist" },
		T = { "<cmd> Telescope<cr>", "Open Telescope" },
		y = { "<cmd> Telescope neoclip<cr>", "yanks" },
		m = { "<cmd> Telescope macroscope<cr>", "macros" },
		o = {
			function()
				vim.cmd("tabnew")
				vim.cmd("Telescope find_files")
			end,
			"Open tab and search files",
		},
		O = {
			function()
				vim.cmd("tabnew")
				require("telescope").extensions.live_grep_args.live_grep_args()
				FEEDKEYS('"" -t sql <Esc>_3li')
			end,
			"macros",
		},
	},
}, { prefix = "<leader>" })
WHICH_KEY({
	["<C-p>"] = { builtin.git_files, "Search files" },
})
