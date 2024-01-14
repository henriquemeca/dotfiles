vim.keymap.set("n","<leader>jd",":call jedi#goto()<CR>", {desc = "jedi go to command"})
vim.keymap.set("n","<leader>ja",":call jedi#goto_assignments()<CR>", {desc = "jedi go to function assigments"})
vim.keymap.set("n","<leader>js",":call jedi#documentation()<CR>", {desc = "jedi"})
vim.keymap.set("n","<leader>ju",":call jedi#usages()<CR>", {desc = "jedi"})
vim.keymap.set("n","<leader>jc",":call jedi#completions()<CR>", {desc = "jedi"})
vim.g['jedi#use_tabs_not_buffers'] = 1

--vim.g['jedi#goto_assignments_command'] = "<leader>g"
--vim.g['jedi#goto_definitions_command'] = ""
--vim.g['jedi#goto_stubs_command'] = "<leader>s"
--vim.g['jedi#documentation_command'] = "K"
--vim.g['jedi#usages_command'] = "<leader>n"
--vim.g['jedi#completions_command'] = "<C-Space>"
--vim.g['jedi#rename_command'] = "<leader>r"
--vim.g['jedi#rename_command_keep_name'] = "<leader>R"
