vim.g.mapleader = " "

-- Quit
VKSN("<leader>q", "<cmd>q<cr>", { desc = "Quit" })
VKSN("<leader>Qq", "<cmd>qa<cr>", { desc = "Quit all" })
VKSN("<leader>Qf", "<cmd>qa!<cr>", { desc = "Quit all (Force)" })
VKSN("gt", "<c-t>", { desc = "Go back on tagstask" })

-- Navigation
VKSN("<C-d>", "<C-d>zz", { desc = "Page down" })
VKSN("<C-u>", "<C-u>zz", { desc = "Page up" })
VKSN("<leader>a", "ggVG", { desc = "Page up" })

VKSV("J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up (on Visual Mode)" })
VKSV("K", ":m '<-2<CR>gv=gv", { desc = "Move seleted lines down (on Visual Mode)" })

VKSN("<C-m>", ":nohl<CR>", { desc = "clear search highlights" })
VKSN("x", '"_x', { desc = "delete single character without copying into register" })

-- Miscellaneous
--vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste and preserve buffer" })
--vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank do clipboard" })
VKSN("<leader>Y", [["+Y]], { desc = "yank line to clipboard" })
VKSN("<leader>W", "qa", { desc = "Record macro on 'a'" })
VKSN("<leader><leader>", function()
    vim.cmd("w")
    vim.cmd("so")
end, { desc = "save file and sources to vim" })

-- Quick changes
VKSN('c"', 'ci"', { desc = 'Change between "' })
VKSN("c'", "ci'", { desc = "Change between '" })
VKSN('c{', 'ci{', { desc = 'Change between {}' })
VKSN('c(', 'ci(', { desc = 'Change between ()' })
VKSN('c[', 'ci[', { desc = 'Change between []' })
VKSN('c<', 'ci<', { desc = 'Change between <>' })

-- window management
VKSN("<leader>wv", "<C-w>v", { desc = "split window vertically" })
VKSN("<leader>we", "<C-w>=", { desc = "make split windows equal width & height" })
VKSN("<leader>ww", "<C-w>w", { desc = "switch window" })
VKSN("<leader>wh", "<C-w>s", { desc = "split window horizontally" })
VKSN("<leader>wx", ":close<CR>", { desc = "close current split window" })
VKSN("<leader>wt", "<C-w>T", { desc = "Break into new tab" })
VKSN("<leader>w<Down>", "<C-w>j", { desc = "Move to down window" })
VKSN("<leader>w<Up>", "<C-w>k", { desc = "Move to up window" })
VKSN("<leader>w<Left>", "<C-w>h", { desc = "Move to left window" })
VKSN("<leader>w<Right>", "<C-w>l", { desc = "Move to right window" })

-- tab management
VKSN("<leader><tab>o", "<cmd>tabnew %<cr>", { desc = "open new tab" })
VKSN("<leader><tab>O", "<cmd>tabnew %<cr><cmd>Telescope find_files<cr>", { desc = "open new tab" })
VKSN("<leader><tab>x", "<cmd>tabclose<cr>", { desc = "close current tab" })
VKSN("<leader><tab>n", "<cmd>tabn<cr>", { desc = "go to next tab" })
VKSN("<leader><tab><tab>", "<cmd>tabn<cr>", { desc = "go to next tab" })
VKSN("<leader><tab>p", "<cmd>tabp<cr>", { desc = "go to previous tab" })
