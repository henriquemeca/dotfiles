vim.keymap.set("n", "<leader>jd", ":call jedi#goto()<CR>", { desc = "go to command" })
vim.keymap.set("n", "<leader>ja", ":call jedi#goto_assignments()<CR>", { desc = "go to function assigments" })
vim.keymap.set("n", "<leader>js", ":call jedi#documentation()<CR>", { desc = "documentation" })
vim.g["jedi#use_tabs_not_buffers"] = 1
