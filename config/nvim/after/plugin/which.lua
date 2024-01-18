local mappings = {
	["<leader>w"] = { name = "+windows" },
	["<leader><Tab>"] = { name = "+tabs" },
	["<leader>c"] = { name = "+comments" },
	["<leader>f"] = { name = "+find" },
	["<leader>g"] = { name = "+git" },
	["<leader>gc"] = { name = "+commits" },
	["<leader>ga"] = { name = "+add" },
	["<leader>gp"] = { name = "+push/pull" },
	["<leader>h"] = { name = "+Gutter highlight" },
	["<leader>j"] = { name = "+jedi" },
	["<leader>n"] = { name = "+clear highlights" },
	["<leader>Q"] = { name = "+quit" },
}
require("which-key").register(mappings)
