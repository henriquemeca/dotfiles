-- Git commands
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "git status" })
vim.keymap.set("n", "<leader>gaa", ":Git add .<CR>", { desc = "git add ." })
vim.keymap.set("n", "<leader>gaf", ":Git add ", { desc = "git add - specific files" })
vim.keymap.set("n", "<leader>gcc", ":Git commit -m ''<Left>", { desc = "git commit - short message" })
vim.keymap.set("n", "<leader>gcm", ":Git commit ", { desc = "git commit - page message" })
vim.keymap.set("n", "<leader>gca", ":Git commit --amend --no-edit<CR>", { desc = "git commit ammend" })
vim.keymap.set("n", "<leader>gco", ":Git checkout ", { desc = "git checkout" })
vim.keymap.set("n", "<leader>gps", ":Git push<CR>", { desc = "git push" })
vim.keymap.set("n", "<leader>gpl", ":Git pull<CR>", { desc = "git pull" })

-- Git tools
vim.keymap.set("n", "<leader>go", ":GBrowse<CR>", { desc = "Open on Browser" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open Diffview Tool" })
vim.keymap.set("n", "<leader>gm", ":Git mergetool<CR>", { desc = "Git Merge Tool" })
vim.keymap.set("n", "<leader>gh", ":Agit<CR>", { desc = "Git History - Agit" })
vim.keymap.set("n", "<leader>gf", ":AgitFile<CR>", { desc = "File Git History - Agit" })
vim.keymap.set("n", "<leader>gF", ":DiffviewFileHistory<CR>", { desc = "File Git History - Diffview" })
