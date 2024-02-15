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
