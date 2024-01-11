vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


vim.keymap.set("x", "<leader>p", [["_dP]], {desc = "paste and preserve buffer"} )
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]],{desc = "yank do clipboard"})
vim.keymap.set("n", "<leader>Y", [["+Y]],{desc = "yank line to clipboard"})

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("w")
    vim.cmd("so")
end,{desc = "save file and sources to vim"})
