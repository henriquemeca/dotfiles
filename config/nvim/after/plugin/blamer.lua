require('packer').startup(function(use)
    -- other plugins ...
    use 'APZelos/blamer.nvim'
    -- other ...
end)
vim.cmd("BlamerShow")
vim.g.blamer_delay = 200
vim.g.blamer_enabled = true

vim.g.blamer_template =
'<author>, <author-mail>, <author-time>, <committer>, <committer-mail>, <committer-time>, <summary>, <commit-short>, <commit-long>'
vim.g.blamer_date_format = '%d/%m/%y'
