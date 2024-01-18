require("conform").setup({
	-- Map of filetype to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		-- You can use a function here to determine the formatters dynamically
		python = { "black" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		sql = { "sqlfluff" },
		markdown = { "prettier" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_fallback = true,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})

vim.keymap.set("n", "<leader>s", "<cmd>w<CR>", { desc = "saves current file" })
