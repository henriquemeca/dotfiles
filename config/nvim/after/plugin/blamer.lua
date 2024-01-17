require('packer').startup(function(use)
   -- other plugins ...
   use 'APZelos/blamer.nvim'
   -- other ...
end)
vim.cmd("BlamerToggle")
vim.g['g:blamer_delay'] = 200
