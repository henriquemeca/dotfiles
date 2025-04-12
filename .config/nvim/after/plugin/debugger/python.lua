local dap = require("dap")

-- Python config
local get_python_path = function()
	return GetCommandPath("python3", "/opt/homebrew/bin/python3")
end

local python_path = get_python_path()

local function get_services()
	local handle = io.popen("nohup docker compose config --services 2>/dev/null")
	if not handle then
		vim.notify("Failed to execute docker-compose command", vim.log.levels.ERROR)
		return nil
	end
	local result = handle:read("*a")
	handle:close()
	return vim.split(result, "\n", { trimempty = true })
end

local function pick_services()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local co = coroutine.running()
	local services = get_services()

	pickers
		.new({}, {
			prompt_title = "Select a service",
			finder = finders.new_table({
				results = services,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						coroutine.resume(co, selection.value)
					end
				end)
				return true
			end,
		})
		:find()

	return coroutine.yield()
end

local function get_images()
	local handle = io.popen("nohup docker compose config --images 2>/dev/null")
	if not handle then
		vim.notify("Failed to execute docker-compose command", vim.log.levels.ERROR)
		return nil
	end
	local result = handle:read("*a")
	handle:close()
	return vim.split(result, "\n", { trimempty = true })
end

local function pick_images()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local co = coroutine.running()
	local images = get_images()

	pickers
		.new({}, {
			prompt_title = "Select a service",
			finder = finders.new_table({
				results = images,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						coroutine.resume(co, selection.value)
					end
				end)
				return true
			end,
		})
		:find()

	return coroutine.yield()
end

dap.adapters.python = function(cb, config)
	if string.find(config.name, "Exec") then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or "127.0.0.1"
		local current_file = vim.api.nvim_buf_get_name(0)
		local cwd = vim.loop.cwd()
		local service = pick_services()
		--local host = get_docker_host(service)
		print(host)

		-- Normalize paths to ensure consistency
		current_file = vim.fn.fnamemodify(current_file, ":p") -- Absolute path
		cwd = vim.fn.fnamemodify(cwd, ":p") -- Absolute path trimmed of trailing slash
		local escaped_cwd = cwd:gsub("([%.%+%-%*%?%[%]%^%$%(%)%%])", "%%%1")
		local relative_file = current_file:gsub("^" .. escaped_cwd, "")

		local docker_cmd = string.format(
			"nohup docker compose exec -d %s python3 -m debugpy --wait-for-client --listen 0.0.0.0:5678 %s &> /dev/null &",
			service,
			relative_file
		)

		print(docker_cmd)
		os.execute(docker_cmd)

		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	elseif string.find(config.name, "Run") then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or "127.0.0.1"
		local current_file = vim.api.nvim_buf_get_name(0)
		local cwd = vim.loop.cwd()
		local image = pick_images()
		local workdir =
			os.capture("docker inspect cloud-composer-repo-airflow-cli --format '{{.Config.WorkingDir}}'", false)

		-- Normalize paths to ensure consistency
		current_file = vim.fn.fnamemodify(current_file, ":p") -- Absolute path
		cwd = vim.fn.fnamemodify(cwd, ":p") -- Absolute path trimmed of trailing slash
		local escaped_cwd = cwd:gsub("([%.%+%-%*%?%[%]%^%$%(%)%%])", "%%%1")
		local relative_file = current_file:gsub("^" .. escaped_cwd, "")

		local docker_cmd = string.format(
			"nohup docker run -d -p 5678:5678 -v .:%s -w %s --entrypoint=/bin/bash %s -c 'python3 -m debugpy --wait-for-client --listen 0.0.0.0:5678 %s' &> /dev/null &",
			workdir,
			workdir,
			image,
			relative_file
		)

		os.execute(docker_cmd)
		--vim.fn.system(docker_cmd)
		print(docker_cmd)
		vim.cmd.sleep(8)

		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	elseif string.find(config.name, "Remote") then
		local port = vim.fn.input("Remote port to connect: ", (config.connect or config).port)
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	elseif config.request == "attach" then
		local port = (config.connect or config).port
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
		justMyCode = true,
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
	{
		name = "Python: Remote Attach - Full Code",
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

		justMyCode = false,
	},
	{
		name = "Python: Remote Attach - Exec container",
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
	{
		name = "Python: Remote Attach - Exec container - Full code",
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

		justMyCode = false,
	},
	{
		name = "Python: Remote Attach - Run container",
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
	{
		name = "Python: Remote Attach - Django",
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
	{
		name = "Python: Remote Attach - Django - Full code",
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

		justMyCode = false,
	},
}
