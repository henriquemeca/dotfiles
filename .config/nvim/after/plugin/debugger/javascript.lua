--require("dap-vscode-js").setup({
--debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
--adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
--})

--require("dap").adapters["pwa-node"] = {
--type = "server",
--host = "localhost",
--port = "${port}",
--executable = {
----command = "js-debug-adapter",
----args = { "${port}" },

--command = "node",
---- 💀 Make sure to update this path to point to your installation
--args = {
----vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/src/dapDebugServer.ts",
----vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js",
--vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
--"${port}",
--},
--},
--}

--local function get_pkg_path(pkg, path)
--pcall(require, "mason")
--local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
--path = path or ""
--local ret = root .. "/packages/" .. pkg .. "/" .. path
--return ret
--end

--require("dap").adapters["pwa-node"] = {
--type = "server",
--host = "localhost",
--port = "${port}",
--executable = {
--command = "node",
--args = {
--get_pkg_path("js-debug-adapter", "js-debug/src/dapDebugServer.js"),
--"${port}",
--},
--},
--}

--print(get_pkg_path("js-debug-adapter", "js-debug/src/dapDebugServer.js"))

require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}", --let both ports be the same for now...
	executable = {
		command = "node",
		-- -- 💀 Make sure to update this path to point to your installation
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
		-- command = "js-debug-adapter",
		-- args = { "${port}" },
	},
}
--require("dap").adapters["pwa-node"] = {
--type = "server",
--host = "localhost",
--port = "8123",
--executable = {
--command = "js-debug-adapter",
--args = { "8123" },
--},
--}

--require("dap").adapters["pwa-chrome"] = {
--type = "server",
--host = "localhost",
--port = "${port}",
--executable = {
--command = "js-debug-adapter",
--args = { "${port}" },
--},
--}

local js_based_languages = { "typescript", "javascript", "typescriptreact" }

for _, language in ipairs(js_based_languages) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",

			profileStartup = true,
			trace = true,
			preserveOutput = true,
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = 'Start Chrome with "localhost"',
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
		},
	}
end
