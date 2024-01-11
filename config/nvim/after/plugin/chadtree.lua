local chadtree_settings ={
   view = {
       sort_by = {"is_folder", "ext", "file_name"},
       width = 40,
       window_options = {
           cursorline = true,
           number = true,
           relativenumber = false,
           signcolumn = "no",
           winfixwidth = true,
           wrap = false
       }
   },
   theme = {
       text_colour_set = "solarized_dark_256"
   }
}

vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

vim.keymap.set("n", "<leader>pv", ':CHADopen<CR>', {desc = "open CHADTree"})
vim.cmd("CHADopen")
