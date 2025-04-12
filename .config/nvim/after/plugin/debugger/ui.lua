local dap = require("dap")

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
