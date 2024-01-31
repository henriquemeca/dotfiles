require("default.remap")
require("default.set")
--vim.api.nvim_input("<CR>") -- Skips initial plugins messages
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

function VKSN(map, func, opts)
    vim.keymap.set("n", map, func, opts)
end

function WHICH_KEY_MAP(mappings)
    require("which-key").register(mappings)
end

function PACKER_SYNC()
    vim.cmd("w")
    vim.cmd("so")
    vim.cmd("PackerSync")

end

vim.cmd([[ command! Psync lua PACKER_SYNC() ]])
