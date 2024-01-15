local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, {desc = "Add file to harpoon"})
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc = "Go to file 1 in harpoon"})
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc = "Go to file 2 in harpoon"})
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = "Go to file 3 in harpoon"})
vim.keymap.set("n", "<leader>4", function() ui.nav_file(3) end, {desc = "Go to file 4 in harpoon"})
