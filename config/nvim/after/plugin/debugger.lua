local dap = require("dap")

-- Python config
local python_path = function()
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python3'
    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python3'
    else
        return '/opt/homebrew/bin/python3'
    end
end

dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        cb({
            type = 'executable',
            command = python_path(),
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end


dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = python_path(),
        args = { '-degug', 'true' },
    },
}

local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end

WHICH_KEY({
    d = {
        name = "Debbug",
        B = { function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Breakpoint Condition" },
        b = { function() dap.toggle_breakpoint() end, "Toggle Breakpoint" },
        c = { function() dap.continue() end, "Continue" },
        C = { function() dap.run_to_cursor() end, "Run to Cursor" },
        g = { function() dap.goto_() end, "Go to line (no execute)" },
        i = { function() dap.step_into() end, "Step Into" },
        j = { function() dap.down() end, "Down" },
        k = { function() dap.up() end, "Up" },
        l = { function() dap.run_last() end, "Run Last" },
        o = { function() dap.step_out() end, "Step Out" },
        O = { function() dap.step_over() end, "Step Over" },
        r = { function() dap.run() end, "Run" },
        R = { function() dap.restart() end, "Restart" },
        s = { function() dap.session() end, "Session" },
        t = { function() dap.terminate() end, "Terminate" },
        p = { function() dap.pause() end, "Pause" },
        --e = { require("dapui").eval(), "Eval" },
        --e = { require("dapui").list_breakpoints(), "List breakpoints" },
        --e = { require("dapui").clear_breakpoints(), "Clear breakpoints" },
        v = { function() require('dap.ext.vscode').load_launchjs() end, "Load .vscode/.launch.json" },
        u = { function() require("dapui").toggle({}) end, "Dap UI" },
        w = { function() require("dap.ui.widgets").hover() end, "Widgets" },
    }
}, { prefix = "<leader>" })
