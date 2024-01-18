vim.g.mapleader = " "

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Qq", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>Qf", "<cmd>qa!<cr>", { desc = "Quit all (Force)" })
vim.keymap.set("n", "gt", "<c-t>", { desc = "Go back on tagstask" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up (on Visual Mode)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move seleted lines down (on Visual Mode)" })

vim.keymap.set("n", "<leader>mh", ":nohl<CR>", { desc = "clear search highlights" })
vim.keymap.set("n", "x", '"_x', { desc = "delete single character without copying into register" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste and preserve buffer" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank do clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line to clipboard" })

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("w")
	vim.cmd("so")
end, { desc = "save file and sources to vim" })

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "make split windows equal width & height" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "switch window" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "split window horizontally" })
vim.keymap.set("n", "<leader>wx", ":close<CR>", { desc = "close current split window" })
vim.keymap.set("n", "<leader>wt", "<C-w>T", { desc = "Break into new tab" })
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", { desc = "Move to right window" })
-- tab management
vim.keymap.set("n", "<leader><tab>o", ":tabnew<CR>", { desc = "open new tab" })
vim.keymap.set("n", "<leader><tab>x", ":tabclose<CR>", { desc = "close current tab" })
vim.keymap.set("n", "<leader><tab>n", ":tabn<CR>", { desc = "go to next tab" })
vim.keymap.set("n", "<leader><tab><tab>", ":tabn<CR>", { desc = "go to next tab" })
vim.keymap.set("n", "<leader><tab>p", ":tabp<CR>", { desc = "go to previous tab" })
