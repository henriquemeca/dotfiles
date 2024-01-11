--Used to simplify the process of syncing new modules

function p_sync()
    vim.cmd("w")
    vim.cmd("so")
    vim.cmd("PackerSync")

end
