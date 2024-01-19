require("default.remap")
require("default.set")
vim.api.nvim_input("<CR>") -- Skips initial plugins messages

function VKSN(map, func, opts)
    vim.keymap.set("n", map, func, opts)
end

function WHICH_KEY_MAP(mappings)
    require("which-key").register(mappings)
end
