local options = {
    defaults = {
        mappings = {
            n = {
                ["f"] = function(prompt_bufnr)
                    local state = require("telescope.state")
                    local action_state = require("telescope.actions.state")
                    local previewer = action_state.get_current_picker(prompt_bufnr).previewer
                    local status = state.get_status(prompt_bufnr)
                    -- Check if we actually have a previewer and a preview window
                    if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                        return
                    end
                    previewer:scroll_fn(1)
                end,
                ["d"] = function(prompt_bufnr)
                    local state = require("telescope.state")
                    local action_state = require("telescope.actions.state")
                    local previewer = action_state.get_current_picker(prompt_bufnr).previewer
                    local status = state.get_status(prompt_bufnr)
                    -- Check if we actually have a previewer and a preview window
                    if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                        return
                    end
                    previewer:scroll_fn(-1)
                end,
            },
        },
        file_ignore_patterns = {
            "node_modules",
            ".git/*",
            "%.zip",
            "%.exe",
            "%.dll",
            ".docker",
            ".git",
            "^vendor/",
        },
    },
    extensions_list = { "themes", "terms", "fzf" },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

return options
