vim.g.mapleader = " "

-- Quit
VKSN("<leader>q", "<cmd>q<cr>", "Quit")
VKSN("<leader>Qq", "<cmd>qa<cr>", "Quit all")
VKSN("<leader>Qf", "<cmd>qa!<cr>", "Quit all (Force)")

-- Navigation
VKSN("<C-[>", "10k", "Half Page up")
VKSN("<C-]>", "10j", "Halg Page down")
VKSN("<C-d>", "<C-d>zz", "Page down")
VKSN("<C-u>", "<C-u>zz", "Page up")
VKSN("<leader>V", "ggVG", "Highlight path")
VKSN("<leader>A", 'ggVG"+y', "Copy page")
VKSN("<leader>hh", function()
	vim.cmd("%!hexdump -C")
end, "Visualize hex")

VKSV("J", ":m '>+1<CR>gv=gv", "Move selected lines up (on Visual Mode)")
VKSV("K", ":m '<-2<CR>gv=gv", "Move seleted lines down (on Visual Mode)")

VKSN("<C-m>", ":nohl<CR>", "clear search highlights")
VKSN("x", '"_x', "delete single character without copying into register")

-- Miscellaneous
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste and preserve buffer" })
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]], { desc = "delete and preserve buffer" })
vim.keymap.set({ "v", "n" }, "<leader>y", [["+y]], { desc = "yank do clipboard" })
VKSN("<leader>Y", '"+Y', "yank all to clipboard")
VKSN("<leader>W", "qa", "Record macro on 'a'")
VKSN("<leader><leader>", function()
	vim.cmd("w")
	vim.cmd("so")
end, "save file and sources to vim")

-- Quick changes
VKSN("c,", "ct,", "Change until ,")
VKSN('c"', 'ci"', 'Change between "')
VKSN("c'", "ci'", "Change between '")
VKSN("c{", "ci{", "Change between {}")
VKSN("c(", "ci(", "Change between ()")
VKSN("c[", "ci[", "Change between []")
VKSN("c<", "ci<", "Change between <>")

VKSN("d)", "dt)", "Delete until )")
VKSN('d"', 'di"', 'Delete between "')
VKSN("d'", "di'", "Delete between '")
VKSN("d{", "di{", "Delete between {}")
VKSN("d(", "di(", "Delete between ()")
VKSN("d[", "di[", "Delete between []")
VKSN("d<", "di<", "Delete between <>")

VKSN('y"', 'yi"', 'Yank between "')
VKSN("y'", "yi'", "Yank between '")
VKSN("y{", "yi{", "Yank between {}")
VKSN("y(", "yi(", "Yank between ()")
VKSN("y[", "yi[", "Yank between []")
VKSN("y<", "yi<", "Yank between <>")

VKSN('v"', 'vi"', 'Visual between "')
VKSN("v'", "vi'", "Visual between '")
VKSN("v{", "vi{", "Visual between {}")
VKSN("v(", "vi(", "Visual between ()")
VKSN("v[", "vi[", "Visual between []")
VKSN("v<", "vi<", "Visual between <>")

-- window management
VKSN("<leader>wv", "<C-w>v", "split window vertically")
VKSN("<leader>we", "<C-w>=", "make split windows equal width & height")
VKSN("<leader>ww", "<C-w>w", "switch window")
VKSN("<leader>wh", "<C-w>s", "split window horizontally")
VKSN("<leader>wx", ":close<CR>", "close current split window")
VKSN("<leader>wt", "<C-w>T", "Break into new tab")
VKSN("<leader>w<Down>", "<C-w>j", "Move to down window")
VKSN("<leader>w<Up>", "<C-w>k", "Move to up window")
VKSN("<leader>w<Left>", "<C-w>h", "Move to left window")
VKSN("<leader>w<Right>", "<C-w>l", "Move to right window")

-- tab management
VKSN("<leader><tab>o", "<cmd>tabnew %<cr>", "open new tab")
VKSN("<leader><tab>O", "<cmd>tabnew %<cr><cmd>Telescope find_files<cr>", "open new tab")
VKSN("<leader><tab>x", "<cmd>tabclose<cr>", "close current tab")
VKSN("<leader><tab>n", "<cmd>tabn<cr>", "go to next tab")
VKSN("<leader><tab><tab>", "<cmd>tabn<cr>", "go to next tab")
VKSN("<leader><tab>p", "<cmd>tabp<cr>", "go to previous tab")

-- Disable movement with shift
vim.api.nvim_set_keymap("n", "<ESC>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Left>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Up>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-Right>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-Left>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-Up>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-Down>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("n", "(", "", { noremap = true })
vim.api.nvim_set_keymap("n", ")", "", { noremap = true })
vim.api.nvim_set_keymap("v", "(", "", { noremap = true })
vim.api.nvim_set_keymap("v", ")", "", { noremap = true })
