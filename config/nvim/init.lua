-- Global setups
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

function VKSN(map, func, opts)
	vim.keymap.set("n", map, func, opts)
end

function VKSI(map, func, opts)
	vim.keymap.set("i", map, func, opts)
end

function VKSV(map, func, opts)
	vim.keymap.set("v", map, func, opts)
end

function FEEDKEYS(keys)
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), "n")
end

require("default")

function WHICH_KEY(mappings, opts)
	require("which-key").register(mappings, opts)
end

function PACKER_SYNC()
	vim.cmd("w")
	vim.cmd("so")
	vim.cmd("PackerSync")
end

vim.cmd([[ command! Psync lua PACKER_SYNC() ]])
