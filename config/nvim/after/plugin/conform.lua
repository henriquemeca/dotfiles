local conform = require("conform")
conform.setup({
	-- Map of filetype to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		-- You can use a function here to determine the formatters dynamically
		python = { "black" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		--yaml = { "prettier" },
		sql = { "sqlfluff" },
		--markdown = { "prettier" },
	},
	--format_on_save = {
	--lsp_fallback = false,
	--timeout_ms = 500,
	--},
	--format_after_save = {
	--lsp_fallback = false,
	--},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})

VKSN("<leader>s", function()
	--vim.lsp.buf.format({ async = true })
	conform.format()
	vim.cmd("w")
end, { desc = "saves current file" })
