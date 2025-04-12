local dap = require("dap")

dap.adapters.php = function(cb, config)
	if string.find(config.name, "test") then
		local current_file = vim.api.nvim_buf_get_name(0)
		local relative_file = current_file:gsub(vim.loop.cwd() .. "/", "")
		print("Executing test:", relative_file)
		local run_test_cmd = string.format("nohup php artisan test %s &> /dev/null &", relative_file)
		os.execute(run_test_cmd)
	end

	if string.find(config.name, "Serve") then
		print("Executing artisan serve")
		os.execute("nohup php artisan serve &> /dev/null &")
	end

	cb({
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
	})
end

dap.configurations.php = {
	{
		name = "Artisan test Attach",
		type = "php",
		request = "launch",
		port = 9003,
	},
	{
		name = "Docker listen for XDebug Attach",
		type = "php",
		request = "launch",
		port = 9003,
		--host = "host.docker.internal",
		pathMappings = {
			["/application"] = "${workspaceFolder}",
			--["/var/www/html/"] = vim.fn.getcwd() .. "/",
		},
	},
	{
		name = "Listen for XDebug Attach",
		type = "php",
		request = "launch",
		port = 9003,
	},
	{
		name = "Run PHP Script",
		type = "php",
		request = "launch",
		port = 9003,
		cwd = "${fileDirname}",
		program = "${file}",
		runtimeExecutable = "php",
		--runtimeArgs = { "${file}" },
		--env = {
		--XDEBUG_CONFIG = "client_host=host.docker.internal",
		--},
	},
	{
		name = "Artisan Serve listen for XDebug Attach",
		type = "php",
		request = "launch",
		port = 9003,
		--log = true,
	},
}
