local dap = require("dap")

-- Caputure output of a shell command
function os.capture(cmd, raw)
	local handle = assert(io.popen(cmd, "r"))
	local output = assert(handle:read("*a"))

	handle:close()

	if raw then
		return output
	end

	output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")

	return output
end

-- Python config
local get_python_path = function()
	--local cwd = vim.fn.getcwd()

	local which_python = os.capture("which python3", false)
	if vim.fn.executable(which_python) == 1 then
		return which_python
	else
		return "/opt/homebrew/bin/python3"
	end
end

local python_path = get_python_path()

dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			enrich_config = function(config, on_config)
				local current_file = vim.api.nvim_buf_get_name(0)
				local relative_file = current_file:gsub(vim.loop.cwd(), ".")

				local docker_cmd = string.format(
					"nohup docker run -d -p 5678:5678 -v .:/app --rm --name debug-test debug %s &> /dev/null &",
					relative_file
				)
				--os.execute("docker kill debug-test &> /dev/null || true")
				--os.execute("docker rm debug-test &> /dev/null || true")
				--os.execute(docker_cmd)
				vim.defer_fn(function()
					on_config(config) -- Continue with the original config
				end, 2000) -- Adjust delay as needed for your Docker container to start
			end,
			options = {
				source_filetype = "python",
			},
		})
	else
		print(python_path)
		cb({
			type = "executable",
			command = python_path,
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		cwd = vim.fn.getcwd(),
		program = "${file}",
		pythonPath = python_path,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch file - Full Code",
		cwd = vim.fn.getcwd(),
		program = "${file}",
		pythonPath = python_path,
		justMyCode = false,
		--args = { "-degug", "true" },
	},
	{
		name = "Python: Remote Attach",
		type = "python",
		request = "attach",
		connect = {
			host = "127.0.0.1",
			port = 5678,
		},
		pathMappings = { {
			localRoot = vim.fn.getcwd(),
			remoteRoot = ".",
		} },

		justMyCode = true,
	},
}

-- Javasript config

require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	debugger_path = "(runtimedir)/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = vim.fn.getcwd(),
		},
	}
end

--dap.adapters.php = {
--type = "executable",
----command = "php",
----args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
--command = "node",
--args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
--}

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

local dapui = require("dapui")
dapui.setup({
	{
		controls = {
			element = "repl",
			enabled = true,
			icons = {
				disconnect = "",
				pause = "",
				play = "",
				run_last = "",
				step_back = "",
				step_into = "",
				step_out = "",
				step_over = "",
				terminate = "",
			},
		},
		element_mappings = {},
		expand_lines = true,
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		force_buffers = true,
		icons = {
			collapsed = "",
			current_frame = "",
			expanded = "",
		},
		layouts = {
			{
				elements = {
					{
						id = "watches",
						size = 0.25,
					},
					{
						id = "stacks",
						size = 0.25,
					},
					{
						id = "scopes",
						size = 0.25,
					},
					{
						id = "breakpoints",
						size = 0.25,
					},
				},
				position = "left",
				size = 40,
			},
			{
				elements = {
					{
						id = "repl",
						size = 0.9,
					},
					{
						id = "console",
						size = 0.1,
					},
				},
				position = "bottom",
				size = 30,
			},
		},
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t",
		},
		render = {
			indent = 1,
			max_value_lines = 100,
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end

WHICH_KEY({
	d = {
		name = "Debbug",
		B = {
			function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			"Breakpoint Condition",
		},
		b = {
			function()
				dap.toggle_breakpoint()
			end,
			"Toggle Breakpoint",
		},
		c = {
			function()
				dap.continue()
			end,
			"Continue",
		},
		C = {
			function()
				dap.run_to_cursor()
			end,
			"Run to Cursor",
		},
		g = {
			function()
				dap.goto_()
			end,
			"Go to line (no execute)",
		},
		i = {
			function()
				dap.step_into()
			end,
			"Step Into",
		},
		j = {
			function()
				dap.down()
			end,
			"Down",
		},
		k = {
			function()
				dap.up()
			end,
			"Up",
		},
		l = {
			function()
				dap.run_last()
			end,
			"Run Last",
		},
		o = {
			function()
				dap.step_out()
			end,
			"Step Out",
		},
		O = {
			function()
				dap.step_over()
			end,
			"Step Over",
		},
		r = {
			function()
				dap.run()
			end,
			"Run",
		},
		R = {
			function()
				dap.restart()
			end,
			"Restart",
		},
		s = {
			function()
				dap.session()
			end,
			"Session",
		},
		t = {
			function()
				dap.terminate()
			end,
			"Terminate",
		},
		p = {
			function()
				dap.pause()
			end,
			"Pause",
		},
		--e = { require("dapui").eval(), "Eval" },
		--e = { require("dapui").list_breakpoints(), "List breakpoints" },
		--e = { require("dapui").clear_breakpoints(), "Clear breakpoints" },
		v = {
			function()
				require("dap.ext.vscode").load_launchjs()
			end,
			"Load .vscode/.launch.json",
		},
		u = {
			function()
				require("dapui").toggle({})
			end,
			"Dap UI",
		},
		U = {
			function()
				FEEDKEYS("<C-w>v")
				require("dapui").toggle({})
			end,
			"Dap UI",
		},
		w = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"Widgets",
		},
	},
}, { prefix = "<leader>" })

VKSN("l", function()
	dap.step_into()
end, "Step Into")

VKSN("L", function()
	dap.step_out()
end, "Step Out")

VKSN("k", function()
	dap.step_over()
end, "Step Over")
