-- Global setups
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.o.autoread = true
--Absolute number
--vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { command = "checktime" })

function VKSN(map, func, description)
	vim.keymap.set("n", map, func, { desc = description })
end

function VKSI(map, func, description)
	vim.keymap.set("i", map, func, { desc = description })
end

function VKSV(map, func, description)
	vim.keymap.set("v", map, func, { desc = description })
end

function FEEDKEYS(keys)
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), "n")
end

function WHICH_KEY(mappings, opts)
	require("which-key").register(mappings, opts)
end

require("config.lazy")
require("config.remap")
require("config.set")
