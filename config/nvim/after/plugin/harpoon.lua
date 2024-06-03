local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

VKSN("<leader>K", mark.add_file, "Add file to harpoon")
VKSN("<leader>L", ui.toggle_quick_menu, "Toggle harppon menu")

VKSN("<leader>1", function()
	ui.nav_file(1)
end, "Go to file 1 in harpoon")
VKSN("<leader>2", function()
	ui.nav_file(2)
end, "Go to file 2 in harpoon")
VKSN("<leader>3", function()
	ui.nav_file(3)
end, "Go to file 3 in harpoon")
VKSN("<leader>4", function()
	ui.nav_file(4)
end, "Go to file 4 in harpoon")
VKSN("<leader>5", function()
	ui.nav_file(5)
end, "Go to file 5 in harpoon")
VKSN("<leader>6", function()
	ui.nav_file(6)
end, "Go to file 6 in harpoon")
VKSN("<leader>7", function()
	ui.nav_file(7)
end, "Go to file 7 in harpoon")

-- Lua
--vim.keymap.set("n", "<leader>Ll", require("grapple").toggle)
--vim.keymap.set("n", "<leader>LL", require("grapple").toggle_tags)

---- User command
--vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>")
