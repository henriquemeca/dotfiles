require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {
            {
                'mode',
                icons_enabled = true, -- Enables the display of icons alongside the component.
                icon = nil,
                separator = nil,      -- Determines what separator to use for the component.
                cond = nil,           -- Condition function, the component is loaded when the function returns `true`.
                draw_empty = false,   -- Whether to draw component even if it's empty.
                color = nil,          -- The default is your theme's color for that section and mode.
                type = nil,
                padding = 1,          -- Adds padding to the left and right of components.
                fmt = nil,            -- Format function, formats the component's output.
                on_click = nil,       -- takes a function that is called when component is clicked with mouse.
            }
        },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
