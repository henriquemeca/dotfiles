--Used to simplify the process of syncing new modules

function PACKER_SYNC()
    vim.cmd("w")
    vim.cmd("so")
    vim.cmd("PackerSync")

end

vim.cmd([[ command! Psync lua PACKER_SYNC() ]])
