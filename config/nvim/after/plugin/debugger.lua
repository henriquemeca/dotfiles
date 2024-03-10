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

-- Check if file or directory exists in the current working directory
local existsInCWD = function(nameToCheck)
	local cwDir = vim.fn.getcwd()

	-- Get all files and directories in CWD
	local cwdContent = vim.split(vim.fn.glob(cwDir .. "/*"), "\n", { trimempty = true })

	-- Check if specified file or directory exists
	local fullNameToCheck = cwDir .. "/" .. nameToCheck
	--print('Checking for: "' .. fullNameToCheck .. '"')
	for _, cwdItem in pairs(cwdContent) do
		if cwdItem == fullNameToCheck then
			--print(fullNameToCheck .. "found")
			return true
		end
	end
	--print(fullNameToCheck .. " not found")
	return false
end

-- Python config
local get_python_path = function()
	local cwd = vim.fn.getcwd()

	if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
		return cwd .. "/venv/bin/python3"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
		return cwd .. "/.venv/bin/python3"
	elseif existsInCWD("poetry.lock") then
		local poetry_path = os.capture("poetry env info --path", false)
		poetry_path = poetry_path .. "/bin/python3"
		if vim.fn.executable(poetry_path) == 1 then
			return poetry_path
		else
			print("Poetry path not found: " .. poetry_path)
			return "/opt/homebrew/bin/python3"
		end
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
			options = {
				source_filetype = "python",
			},
		})
	else
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
		args = { "-degug", "true" },
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
						id = "scopes",
						size = 0.25,
					},
					{
						id = "breakpoints",
						size = 0.25,
					},
					{
						id = "stacks",
						size = 0.25,
					},
					{
						id = "watches",
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
						size = 0.5,
					},
					{
						id = "console",
						size = 0.5,
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
