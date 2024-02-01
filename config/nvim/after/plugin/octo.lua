local remappings = {
    issue = {
        close_issue = { lhs = "<leader>oiic", desc = "close issue" },
        reopen_issue = { lhs = "<leader>oiio", desc = "reopen issue" },
        list_issues = { lhs = "<leader>oiil", desc = "list open issues on same repo" },
        reload = { lhs = "<leader>R", desc = "reload issue" },
        open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        add_assignee = { lhs = "<leader>oiaa", desc = "add assignee" },
        remove_assignee = { lhs = "<leader>oiad", desc = "remove assignee" },
        create_label = { lhs = "<leader>oilc", desc = "create label" },
        add_label = { lhs = "<leader>oila", desc = "add label" },
        remove_label = { lhs = "<leader>oild", desc = "remove label" },
        goto_issue = { lhs = "<leader>oigi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<leader>oica", desc = "add comment" },
        delete_comment = { lhs = "<leader>oicd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<leader>oirp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<leader>oirh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<leader>oire", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<leader>oir+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<leader>oir-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<leader>oirr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<leader>oirl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<leader>oirc", desc = "add/remove 😕 reaction" },
    },
    pull_request = {
        checkout_pr = { lhs = "<leader>opc", desc = "checkout PR" },
        merge_pr = { lhs = "<leader>opm", desc = "merge commit PR" },
        squash_and_merge_pr = { lhs = "<leader>opsm", desc = "squash and merge PR" },
        list_commits = { lhs = "<leader>opc", desc = "list PR commits" },
        list_changed_files = { lhs = "<leader>opf", desc = "list PR changed files" },
        show_pr_diff = { lhs = "<leader>opd", desc = "show PR diff" },
        add_reviewer = { lhs = "<leader>opva", desc = "add reviewer" },
        remove_reviewer = { lhs = "<leader>opvd", desc = "remove reviewer request" },
        close_issue = { lhs = "<leader>opic", desc = "close PR" },
        reopen_issue = { lhs = "<leader>opio", desc = "reopen PR" },
        list_issues = { lhs = "<leader>opil", desc = "list open issues on same repo" },
        reload = { lhs = "<leader>R", desc = "reload PR" },
        open_in_browser = { lhs = "<leader>opb", desc = "open PR in browser" },
        copy_url = { lhs = "<leader>opu", desc = "copy url to system clipboard" },
        goto_file = { lhs = "gf", desc = "go to file" },
        add_assignee = { lhs = "<leader>opaa", desc = "add assignee" },
        remove_assignee = { lhs = "<leader>opad", desc = "remove assignee" },
        create_label = { lhs = "<leader>oplc", desc = "create label" },
        add_label = { lhs = "<leader>opla", desc = "add label" },
        remove_label = { lhs = "<leader>opld", desc = "remove label" },
        goto_issue = { lhs = "<leader>opgi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<leader>opca", desc = "add comment" },
        delete_comment = { lhs = "<leader>opcd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<leader>oprp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<leader>oprh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<leader>opre", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<leader>opr+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<leader>opr-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<leader>oprr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<leader>oprl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<leader>oprc", desc = "add/remove 😕 reaction" },
    },
    review_thread = {
        goto_issue = { lhs = "<leader>otgi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<leader>otca", desc = "add comment" },
        add_suggestion = { lhs = "<leader>otsa", desc = "add suggestion" },
        delete_comment = { lhs = "<leader>otcd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        select_next_entry = { lhs = "]f", desc = "move to previous changed file" },
        select_prev_entry = { lhs = "[f", desc = "move to next changed file" },
        select_first_entry = { lhs = "[F", desc = "move to first changed file" },
        select_last_entry = { lhs = "]F", desc = "move to last changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        react_hooray = { lhs = "<leader>otrp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<leader>otrh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<leader>otre", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<leader>otr+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<leader>otr-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<leader>otrr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<leader>otrl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<leader>otrc", desc = "add/remove 😕 reaction" },
    },
    submit_win = {
        approve_review = { lhs = "<C-a>", desc = "approve review" },
        comment_review = { lhs = "<C-m>", desc = "comment review" },
        request_changes = { lhs = "<C-r>", desc = "request changes review" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    },
    review_diff = {
        add_review_comment = { lhs = "<leader>oca", desc = "add a new review comment" },
        add_review_suggestion = { lhs = "<leader>ocs", desc = "add a new review suggestion" },
        focus_files = { lhs = "<leader>b", desc = "move focus to changed file panel" },
        toggle_files = { lhs = "<leader>B", desc = "hide/show changed files panel" },
        next_thread = { lhs = "]t", desc = "move to next thread" },
        prev_thread = { lhs = "[t", desc = "move to previous thread" },
        select_next_entry = { lhs = "]f", desc = "move to previous changed file" },
        select_prev_entry = { lhs = "[f", desc = "move to next changed file" },
        select_first_entry = { lhs = "[F", desc = "move to first changed file" },
        select_last_entry = { lhs = "]F", desc = "move to last changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<leader>v", desc = "toggle viewer viewed state" },
        goto_file = { lhs = "gf", desc = "go to file" },
    },
    file_panel = {
        next_entry = { lhs = "j", desc = "move to next changed file" },
        prev_entry = { lhs = "k", desc = "move to previous changed file" },
        select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
        refresh_files = { lhs = "R", desc = "refresh changed files panel" },
        focus_files = { lhs = "<leader>b", desc = "move focus to changed file panel" },
        toggle_files = { lhs = "<leader>B", desc = "hide/show changed files panel" },
        select_next_entry = { lhs = "]f", desc = "move to previous changed file" },
        select_prev_entry = { lhs = "[f", desc = "move to next changed file" },
        select_first_entry = { lhs = "[F", desc = "move to first changed file" },
        select_last_entry = { lhs = "]F", desc = "move to last changed file" },
        close_review_tab = { lhs = "<c-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<leader>v", desc = "toggle viewer viewed state" },
    },
}

--- Read the key mapping from octo.nvim
--- then convert it to flat table which sutable for display in Telescope
local function flat(mappings)
    local flatted = {}
    -- loop through all the mappings
    for topic, commands in pairs(mappings) do
        for func, command in pairs(commands) do
            table.insert(flatted, { topic = topic, func = func, lhs = command.lhs, desc = command.desc })
        end
    end

    return flatted
end

local flatted_mapping = flat(remappings)

require "octo".setup({
    use_local_fs = true,                       -- use local files on right side of reviews
    enable_builtin = true,                     -- shows a list of builtin actions when no action is provided
    default_remote = { "origin", "upstream" }, -- order to try remotes
    default_merge_method = "commit",           -- default merge method which should be used when calling `Octo pr merge`, could be `commit`, `rebase` or `squash`
    ssh_aliases = {},                          -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
    picker = "telescope",                      -- or "fzf-lua"
    picker_config = {
        use_emojis = false,                    -- only used by "fzf-lua" picker for now
        mappings = {                           -- mappings for the pickers
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
            merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
        },
    },
    comment_icon = "▎", -- comment marker
    outdated_icon = "󰅒 ", -- outdated indicator
    resolved_icon = " ", -- resolved indicator
    reaction_viewer_hint_icon = " ", -- marker for user reactions
    user_icon = " ", -- user icon
    timeline_marker = " ", -- timeline marker
    timeline_indent = "2", -- timeline indentation
    right_bubble_delimiter = "", -- bubble delimiter
    left_bubble_delimiter = "", -- bubble delimiter
    github_hostname = "", -- GitHub Enterprise host
    snippet_context_lines = 4, -- number or lines around commented lines
    gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
    timeout = 5000, -- timeout for requests between the remote server
    default_to_projects_v2 = true, -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
    ui = {
        use_signcolumn = true, -- show "modified" marks on the sign column
    },
    issues = {
        order_by = {              -- criteria to sort results of `Octo issue list`
            field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction =
            "DESC"                -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
        }
    },
    pull_requests = {
        order_by = {                           -- criteria to sort the results of `Octo pr list`
            field = "CREATED_AT",              -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction =
            "DESC"                             -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
        },
        always_select_remote_on_create = false -- always give prompt to select base remote repo when creating PRs
    },
    file_panel = {
        size = 10,       -- changed files panel rows
        use_icons = true -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
    },
    colors = {           -- used for highlight groups (see Colors section below)
        white = "#ffffff",
        grey = "#2A354C",
        black = "#000000",
        red = "#fdb8c0",
        dark_red = "#da3633",
        green = "#acf2bd",
        dark_green = "#238636",
        yellow = "#d3c846",
        dark_yellow = "#735c0f",
        blue = "#58A6FF",
        dark_blue = "#0366d6",
        purple = "#6f42c1",
    },
    mappings = remappings
})

VKSN("<leader>oa", "<cmd>Octo actions<cr>", { desc = "Show octo actions" })
-- PRs
VKSN("<leader>opl", "<cmd>Octo pr list<cr>", { desc = "List PRs" })
VKSN("<leader>ops", "<cmd>Octo pr search<cr>", { desc = "Search PRs" })
VKSN("<leader>ope", "<cmd>Octo pr edit", { desc = "Open PR by number" })
VKSN("<leader>opu", "<cmd>Octo pr ", { desc = "Open PR by URL" })
VKSN("<leader>opC", "<cmd>Octo pr create<cr>", { desc = "Create PR" })
--VKSN("<leader>opc", "<cmd>Octo pr checkout<cr>", { desc = "Checkout PR" })
--VKSN("<leader>opw", "<cmd>Octo pr checks<cr>", { desc = "Check workflows" })
--VKSN("<leader>opr", "<cmd>Octo pr reload<cr>", { desc = "Reload PR" })
--VKSN("<leader>opb", "<cmd>Octo pr browser<cr>", { desc = "Open PR on browser" })
---- Comments
--VKSN("<leader>oca", "<cmd>Octo comment add<cr>", { desc = "Add comment" })
--VKSN("<leader>ocd", "<cmd>Octo comment delete<cr>", { desc = "Delete comment" })
---- Threads
--VKSN("<leader>ocr", "<cmd>Octo thread resolve<cr>", { desc = "Thread resolve" })
--VKSN("<leader>ocu", "<cmd>Octo thread unresolve<cr>", { desc = "Thread unresolve" })
---- Reviews
--VKSN("<leader>ors", "<cmd>Octo review start<cr>", { desc = "Start a review" })
--VKSN("<leader>orS", "<cmd>Octo review submit<cr>", { desc = "Submit a review" })
--VKSN("<leader>ore", "<cmd>Octo review resume<cr>", { desc = "Edit pending review" })
--VKSN("<leader>ord", "<cmd>Octo review discard<cr>", { desc = "Discard review" })
--VKSN("<leader>orc", "<cmd>Octo review close<cr>", { desc = "Close window review" })
--TODO VKSN("<lactionsactionseader>ocu", "<cmd>Octo thread unresolve", { desc = "Thread unresolve" }) add reactions



for _, mapping in pairs(flatted_mapping) do
    WHICH_KEY_MAP({ [mapping.lhs] = { name = mapping.desc } })
end

WHICH_KEY_MAP({
    ["<leader>o"] = { name = "+GitHub" },
    ["<leader>op"] = { name = "+PR" },
    ["<leader>oc"] = { name = "+commet" },
    ["<leader>or"] = { name = "+Review" },
    ["<leader>ot"] = { name = "+Thread" },
    ["<leader>oi"] = { name = "+Issue" },
})



-- Create picker for octo mappings
local telescope_conf = require("telescope.config").values
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local entry_display = require("telescope.pickers.entry_display")



local make_display = function(entry)
    -- print("called make_display", vim.inspect(entry))
    if not entry then
        return nil
    end

    local columns = {
        { entry.object.topic, "TelescopeResultsNumber" },
        { entry.object.func,  "TelescopeResultsFunction" },
        { entry.object.desc,  "TelescopeResultsNumber" },
        { entry.object.lhs,   "TelescopeResultsNumber" },
        -- { entry.ordinal, "TelescopeResultsNumber" },
    }

    local displayer = entry_display.create({
        separator = " | ",
        items = {
            { width = 20 },
            { width = 25 },
            { width = 50 },
            { remaining = true },
        },
    })

    return displayer(columns)
end

local entry_maker = function(entry)
    -- print("called entry_maker", (entry))
    return {
        display = make_display,
        value = entry.desc,
        ordinal = entry.topic .. entry.func .. entry.desc, -- text use for filter
        object = entry,
    }
end

local close_picker = function(prompt_bufnr)
    local selection = require("telescope.actions.state").get_selected_entry()
    actions.close(prompt_bufnr)
    local func_to_call = selection.object.func
    local m = require("octo.mappings")
    m[func_to_call]()
end

local function create_picker()
    pickers
        .new({}, {
            prompt_title = "Octo operations",
            finder = finders.new_table({
                results = flatted_mapping, -- The result set, find by the finder
                entry_maker = entry_maker, -- formating the result
            }),
            sorter = telescope_conf.generic_sorter(),
            attach_mappings = function(prompt_bufnr, map)
                -- <CR> will close the picker
                map("i", "<CR>", close_picker)
                map("n", "<CR>", close_picker)
                return true
            end,
        })
        :find()
end

VKSN("<leader>O", function()
    vim.fn.bufnr()
    create_picker()
end, { desc = "Open Octo operations" })
