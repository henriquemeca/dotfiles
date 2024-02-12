require("default.remap")
require("default.set")
--vim.api.nvim_input("<CR>") -- Skips initial plugins messages
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

function WHICH_KEY(mappings, opts)
    require("which-key").register(mappings, opts)
end

function PACKER_SYNC()
    vim.cmd("w")
    vim.cmd("so")
    vim.cmd("PackerSync")
end

vim.cmd([[ command! Psync lua PACKER_SYNC() ]])
