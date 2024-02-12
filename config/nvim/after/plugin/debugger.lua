local dap = require("dap")

dap.adapters.python = {
    type = 'executable',
    command = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python3'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python3'
        else
            return '/opt/homebrew/bin/python3'
        end
    end,
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python3'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python3'
            else
                return '/opt/homebrew/bin/python3'
            end
        end,
        args = { '-degug', 'true' },
    },
}

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

require("nvim-dap-virtual-text").setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = false,           -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
    all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- param buf number
    --- param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
        else
            return variable.name .. ' = ' .. variable.value
        end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

require("mason").setup()
require("mason-nvim-dap").setup({
    handlers = {
        function(config)
            require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
            --config.adapters = {
            --type = "executable",
            --command = "/usr/bin/python3",
            --args = {
            --"-m",
            --"debugpy.adapter",
            --},
            --}
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
    }
})

VKSN("<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = "Breakpoint Condition" })
VKSN("<leader>db", function() require("dap").toggle_breakpoint() end,
    { desc = "Toggle Breakpoint" })
VKSN("<leader>dc", function() require("dap").continue() end,
    { desc = "Continue" })
VKSN("<leader>dC", function() require("dap").run_to_cursor() end,
    { desc = "Run to Cursor" })
VKSN("<leader>dg", function() require("dap").goto_() end,
    { desc = "Go to line (no execute)" })
VKSN("<leader>di", function() require("dap").step_into() end,
    { desc = "Step Into" })
VKSN("<leader>dj", function() require("dap").down() end, { desc = "Down" })
VKSN("<leader>dk", function() require("dap").up() end, { desc = "Up" })
VKSN("<leader>dl", function() require("dap").run_last() end,
    { desc = "Run Last" })
VKSN("<leader>do", function() require("dap").step_out() end,
    { desc = "Step Out" })
VKSN("<leader>dO", function() require("dap").step_over() end,
    { desc = "Step Over" })
VKSN("<leader>dp", function() require("dap").pause() end, { desc = "Pause" })
VKSN("<leader>dr", function() require("dap").run() end,
    { desc = "Run" })
VKSN("<leader>dR", function() require("dap").restart() end,
    { desc = "Restart" })
VKSN("<leader>ds", function() require("dap").session() end,
    { desc = "Session" })
VKSN("<leader>dt", function() require("dap").terminate() end,
    { desc = "Terminate" })
VKSN("<leader>dw", function() require("dap.ui.widgets").hover() end,
    { desc = "Widgets" })
VKSN("<leader>du", function() require("dapui").toggle({}) end,
    { desc = "Dap UI" })
VKSN("<leader>de", function() require("dapui").eval() end, { desc = "Eval" })
VKSN("<leader>de", function() require("dapui").list_breakpoints() end, { desc = "List breakpoints" })
VKSN("<leader>de", function() require("dapui").clear_breakpoints() end, { desc = "Clear breakpoints" })
VKSN("<leader>dv", function() require('dap.ext.vscode').load_launchjs() end, { desc = "Load .vscode/.launch.json" })

WHICH_KEY({
    ["<leader>d"] = { name = "+debbug" }
})
