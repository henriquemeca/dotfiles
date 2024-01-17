vim.keymap.set("n", "<leader>Qs", "[[<cmd>lua require('persistence').load()<cr>]]", { desc = "restore the session for the current directory" })
vim.keymap.set("n", "<leader>Ql", "[[<cmd>lua require('persistence').load({last=true})<cr>]]", { desc = "restore the session for the current directory" })
vim.keymap.set("n", "<leader>Qd", "[[<cmd>lua require('persistence').stop()<cr>]]", { desc = "restore the session for the current directory" })
