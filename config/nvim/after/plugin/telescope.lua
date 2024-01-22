local builtin = require("telescope.builtin")
-- For light theme

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
vim.keymap.set("n", "<leader>t", "<cmd>Telescope tagstack<cr>", { desc = "list available help tags" })
vim.keymap.set("n", "<leader>ft", "<cmd> Telescope<cr>", { desc = "Open Telescope" })
vim.keymap.set("n", "<leader>fT", "<c-w>v<cmd> Telescope<cr>", { desc = "Open Telescope" })
vim.keymap.set("n", "<leader>fy", "<cmd> Telescope neoclip<cr>", { desc = "Telescope yanks" })
