VKSN('<leader>P', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
VKSN('<leader>pw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>pw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
VKSN('<leader>pp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
