local conform = require("conform")
local prettier = { "prettierd", "prettier", stop_after_first = true }
conform.setup({
	-- Map of filetype to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = prettier,
		typescript = prettier,
		typescriptreact = prettier,
		javascriptreact = prettier,
		-- You can use a function here to determine the formatters dynamically
		--python = { "pyright" },
		python = function(bufnr)
			if require("conform").get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_format", "ruff_organize_imports" }
			else
				return { "black" }
			end
		end,
		css = prettier,
		html = prettier,
		json = prettier,
		yaml = prettier,
		sql = { "sqlfluff" },
		php = { "pint" },
		markdown = prettier,
		terraform = { "terraform_fmt" },
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
	local extension = vim.fn.expand("%:e")
	--if extension == "py" then
	--vim.cmd("PyrightOrganizeImports")
	--end
	conform.format()
	vim.cmd("w")
end, "saves current file")
