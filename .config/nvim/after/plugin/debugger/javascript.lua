require("dap").adapters["pwa-node"] = function(cb, config)
	--raw commands
	--node /Users/henrique.brito/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js 8123
	--node --inspect-brk ./file_path.hs
	local debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
	print(debugger_path)
	cb({
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "node",
			args = {
				debugger_path,
				"${port}",
			},
		},
	})
end

local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

for _, language in ipairs(js_based_languages) do
	require("dap").configurations[language] = {
		-- Debug single nodejs files
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Jest Current File",
			runtimeExecutable = "pnpm",
			runtimeArgs = {
				"jest",
				"--runTestsByPath",
				"${relativeFile}",
				"--config",
				"jest.config.js",
				"--no-cache",
			},
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			disableOptimisticBPs = true,
			cwd = "${workspaceFolder}",
			env = {
				NODE_ENV = "test",
				NODE_OPTIONS = "--enable-source-maps",
			},
			sourceMaps = true,
			-- pnpm paths mapping
			outFiles = { "!**/node_modules/.pnpm/**/*.js.map" },
			skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Jest Current File E2E",
			runtimeExecutable = "pnpm",
			runtimeArgs = {
				"jest",
				"--runTestsByPath",
				"${relativeFile}",
				"--config",
				"./test/jest-e2e.json",
				"--no-cache",
			},
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			disableOptimisticBPs = true,
			cwd = "${workspaceFolder}",
			env = {
				NODE_ENV = "test",
				NODE_OPTIONS = "--enable-source-maps",
			},
			sourceMaps = true,
			-- pnpm paths mapping
			outFiles = { "!**/node_modules/.pnpm/**/*.js.map" },
		},
		{
			name = "Attach to local Debugger",
			type = "pwa-node",
			request = "attach",
			port = 9229,
			restart = true, --restart on code change
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			cwd = "${workspaceFolder}",
			skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
			sourceMaps = true,
			protocol = "inspector",
			traces = true,
		},
		{
			name = "Attach to Docker Debugger",
			type = "pwa-node",
			request = "attach",
			port = 9229,
			restart = true, --restart on code change
			cwd = "${workspaceFolder}",
			localRoot = vim.fn.getcwd(),
			remoteRoot = "/usr/src/app",
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
			sourceMaps = true,
			protocol = "inspector",
			traces = true,
		},
		-- Debug nodejs processes (make sure to add --inspect when you run the process)
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Proccess",
			processId = require("dap.utils").pick_process,
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		-- Debug web applications (client side)
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({
						prompt = "Enter URL: ",
						default = "http://localhost:3000",
					}, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = vim.fn.getcwd(),
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},
	}
end

-- other configs
--{
--type = "pwa-node",
--request = "launch",
--name = "Launch Current TS File (ts-node)",
--runtimeExecutable = "npx",
--runtimeArgs = { "ts-node" },
--args = { "${file}" },
--cwd = "${workspaceFolder}",
--sourceMaps = true,
--protocol = "inspector",
--skipFiles = { "<node_internals>/**", "node_modules/**" },
--resolveSourceMapLocations = {
--"${workspaceFolder}/**",
--"!**/node_modules/**",
--},
--},

---- Debug Jest tests
--{
--type = "pwa-node",
--request = "launch",
--name = "Debug Jest Tests",
--runtimeExecutable = "npx",
--runtimeArgs = { "jest", "--runInBand" },
--rootPath = "${workspaceFolder}",
--cwd = "${workspaceFolder}",
--console = "integratedTerminal",
--internalConsoleOptions = "neverOpen",
--sourceMaps = true,
--skipFiles = { "<node_internals>/**", "node_modules/**" },
--},

---- Debug current Jest test file
--{
--type = "pwa-node",
--request = "launch",
--name = "Debug Current Jest Test File",
--runtimeExecutable = "npx",
--runtimeArgs = { "jest", "--runInBand", "${relativeFile}" },
--rootPath = "${workspaceFolder}",
--cwd = "${workspaceFolder}",
--console = "integratedTerminal",
--internalConsoleOptions = "neverOpen",
--sourceMaps = true,
--skipFiles = { "<node_internals>/**", "node_modules/**" },
--},

---- Debug NestJS E2E tests
--{
--type = "pwa-node",
--request = "launch",
--name = "Debug NestJS E2E Tests",
--runtimeExecutable = "npm",
--runtimeArgs = { "run", "test:e2e" },
--rootPath = "${workspaceFolder}",
--cwd = "${workspaceFolder}",
--console = "integratedTerminal",
--internalConsoleOptions = "neverOpen",
--sourceMaps = true,
--skipFiles = { "<node_internals>/**", "node_modules/**" },
--},

---- Debug specific NestJS E2E test file
--{
--type = "pwa-node",
--request = "launch",
--name = "Debug Current E2E Test File",
--runtimeExecutable = "npx",
--runtimeArgs = { "jest", "--config", "./test/jest-e2e.json", "--runInBand", "${relativeFile}" },
--rootPath = "${workspaceFolder}",
--cwd = "${workspaceFolder}",
--console = "integratedTerminal",
--internalConsoleOptions = "neverOpen",
--sourceMaps = true,
--skipFiles = { "<node_internals>/**", "node_modules/**" },
--},

---- Debug NestJS application
--{
--type = "pwa-node",
--request = "launch",
--name = "Debug NestJS Application",
--runtimeExecutable = "npm",
--runtimeArgs = { "run", "start:debug" },
--rootPath = "${workspaceFolder}",
--cwd = "${workspaceFolder}",
--console = "integratedTerminal",
--internalConsoleOptions = "neverOpen",
--sourceMaps = true,
--skipFiles = { "<node_internals>/**", "node_modules/**" },
--resolveSourceMapLocations = {
--"${workspaceFolder}/**",
--"!**/node_modules/**",
--},
--},

---- Standard Node.js debugging
--{
--type = "pwa-node",
--request = "launch",
--name = "Launch File",
--program = "${file}",
--cwd = "${workspaceFolder}",
--sourceMaps = true,
--},

---- Attach to an already running Node.js process
--{
--type = "pwa-node",
--request = "attach",
--name = "Attach",
--processId = require("dap.utils").pick_process,
--cwd = "${workspaceFolder}",
--sourceMaps = true,
--},

---- Debug web application in Chrome
--{
--type = "pwa-chrome",
--request = "launch",
--name = 'Start Chrome with "localhost"',
--url = "http://localhost:3000",
--webRoot = "${workspaceFolder}",
--userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
--sourceMaps = true,
--},
