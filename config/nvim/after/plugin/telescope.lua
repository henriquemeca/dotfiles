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
        prompt_prefix = "   ",
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

vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set(
    "n",
    "<leader>ff",
    "<cmd>Telescope find_files<cr>",
    { desc = "find files" }
)
vim.keymap.set(
    "n",
    "<leader>fF",
    "<c-w>v<cmd>Telescope find_files<cr>",
    { desc = "find files in new vertical buffer" }
)
vim.keymap.set(
    "n",
    "<leader>fs",
    "<cmd>Telescope live_grep<cr>",
    { desc = "find string in current working directory as you type" }
)
vim.keymap.set(
    "n",
    "<leader>fS",
    "<c-w>v<cmd>Telescope live_grep<cr>",
    { desc = "find string in current working directory as you type" }
)
vim.keymap.set(
    "n",
    "<leader>fc",
    "<cmd>Telescope grep_string<cr>",
    { desc = "find string under cursor in current working directory" }
)
vim.keymap.set(
    "n",
    "<leader>fb",
    "<cmd>Telescope buffers<cr>",
    { desc = "list open buffers in current neovim instance" }
)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "list available help tags" })
vim.keymap.set("n", "<leader>t", "<cmd>Telescope tagstack<cr>", { desc = "Open Tagstack" })
vim.keymap.set("n", "<leader>ft", "<cmd> Telescope<cr>", { desc = "Open Telescope" })
vim.keymap.set("n", "<leader>fT", "<c-w>v<cmd> Telescope<cr>", { desc = "Open Telescope" })
vim.keymap.set("n", "<leader>fy", "<cmd> Telescope neoclip<cr>", { desc = "Telescope yanks" })
