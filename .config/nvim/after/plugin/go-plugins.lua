require("dap-go").setup({
	dap_configurations = {
		{
			type = "go",
			name = "Attach local",
			mode = "remote",
			request = "attach",
			host = "localhost",
			port = function()
				local port = vim.fn.input("Port: ", "2345")
				return tonumber(port)
			end,
		},
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
			host = "localhost",
			apiVersion = 2,
			port = function()
				local port = vim.fn.input("Port: ", "2345")
				return tonumber(port)
			end,
			showLog = true,
			trace = "verbose",
			logOutput = "rpc",
			substitutePath = {
				{
					from = vim.fn.getcwd(),
					to = "/app",
				},
			},
			stopOnEntry = false,
			showGlobalVariables = true,
		},
	},
	-- delve configurations
	delve = {
		-- the path to the executable dlv which will be used for debugging.
		-- by default, this is the "dlv" executable on your PATH.
		path = "dlv",
		-- time to wait for delve to initialize the debug session.
		-- default to 20 seconds
		initialize_timeout_sec = 20,
		-- a string that defines the port to start delve debugger.
		-- default to string "${port}" which instructs nvim-dap
		-- to start the process in a random available port.
		-- if you set a port in your debug configuration, its value will be
		-- assigned dynamically.
		port = "${port}",
		-- additional args to pass to dlv
		args = {},
		-- the build flags that are passed to delve.
		-- defaults to empty string, but can be used to provide flags
		-- such as "-tags=unit" to make sure the test suite is
		-- compiled during debugging, for example.
		-- passing build flags using args is ineffective, as those are
		-- ignored by delve in dap mode.
		-- avaliable ui interactive function to prompt for arguments get_arguments
		build_flags = {},
		-- whether the dlv process to be created detached or not. there is
		-- an issue on delve versions < 1.24.0 for Windows where this needs to be
		-- set to false, otherwise the dlv server creation will fail.
		-- avaliable ui interactive function to prompt for build flags: get_build_flags
		detached = vim.fn.has("win32") == 0,
		-- the current working directory to run dlv from, if other than
		-- the current working directory.
		cwd = vim.fn.getcwd(),
	},
	-- options related to running closest test
	tests = {
		-- enables verbosity when running the test.
		verbose = false,
	},
})

require("gopher").setup()
WHICH_KEY({
	G = {
		name = "Go plugins",
		e = {
			function()
				local keys = "oif err != nil {\n\treturn err\nlog.Fatalf(err)\npanic(err)\n}<ESC>3k"
				FEEDKEYS(keys)
			end,
			"add err template",
		},
		t = {
			name = "Tests",
			a = {
				function()
					vim.cmd("GoTestAdd")
				end,
				"add one test for function under cursor",
			},
			A = {
				function()
					vim.cmd("GoTestAll")
				end,
				"add all tests for all functions in current file",
			},
			e = {
				function()
					vim.cmd("GoTestsExp")
				end,
				"add tests only for exported functions in current file",
			},
		},
		g = {
			name = "add Tags",
			j = {
				function()
					vim.cmd("GoTagAdd json")
				end,
				"Add json tags",
			},
			y = {
				function()
					vim.cmd("GoTagAdd json")
				end,
				"Add yaml tags",
			},
		},
		F = {
			function()
				vim.cmd("GoFillStruct")
			end,
			"Fill Struct",
		},
	},
}, { prefix = "<leader>" })

--Other commands
--:GoGet github.com/gorilla/mux

--" Link can have an `http` or `https` prefix.
--:GoGet https://github.com/lib/pq

--" You can provide more than one package url
--:GoGet github.com/jackc/pgx/v5 github.com/google/uuid/

--" go mod commands
--:GoMod tidy
--:GoMod init new-shiny-project

--" go work commands
--:GoWork sync

--" run go generate in cwd
--:GoGenerate

--" run go generate for the current file
--:GoGenerate %
--:GoImpl r Read io.Reader
--:GoImpl Write io.Writer

--" or you can simply put a cursor on the struct and run
--:GoImpl io.Reader
--Boilerplates for doc comments
--:GoCmt
