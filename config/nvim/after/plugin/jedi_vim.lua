vim.keymap.set("n","<leader>jd",":call jedi#goto()<CR>", {desc = "jedi go to command"})
vim.keymap.set("n","<leader>ja",":call jedi#goto_assignments()<CR>", {desc = "jedi go to function assigments"})
vim.keymap.set("n","<leader>js",":call jedi#documentation()<CR>", {desc = "jedi"})
vim.keymap.set("n","<leader>ju",":call jedi#usages()<CR>", {desc = "jedi"})
vim.keymap.set("n","<leader>jc",":call jedi#completions()<CR>", {desc = "jedi"})
vim.g['jedi#use_tabs_not_buffers'] = 1

