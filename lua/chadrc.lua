-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

local stbufnr = function()
    return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "solarized_dark",
    hl_override = {
        -- CursorLine = { bg = "#1A5058" },
        Visual = { bg = "#CFCFBA" },

        CursorLineNr = { bg = "#cfcaba" },

        -- :Telescope highlights 查看支持插件可以配置都theme选项
        NvimTreeCursorLine = { bg = "#1A5058" },
        NvimTreeLineNr = { bg = "#cfcaba" },
        TelescopeSelection = { bg = "#888888" },
    },
}

-- https://github.com/NvChad/ui/blob/v2.5/lua/nvchad/stl/utils.lua#L12
-- https://github.com/NvChad/NvChad/commit/cd5d85a11b5eecaf12d9a9f420e8924ed6a214d7#commitcomment-77606986
M.ui = {
    statusline = {
        separator_style = "round",
        theme = "default",
        order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
        modules = {
            file = function()
                local icon = "󰈚"
                local path = vim.api.nvim_buf_get_name(stbufnr())
                local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

                if name ~= "Empty " then
                    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

                    if devicons_present then
                        local ft_icon = devicons.get_icon(name)
                        icon = (ft_icon ~= nil and ft_icon) or icon
                    end
                end

                local rPath = vim.fn.expand("%:.:h")
                local rName = rPath .. "/" .. name
                local maxLength = 53
                if string.len(rName) > maxLength then
                    rName = string.sub(rName, string.len(rName) - maxLength + 3, string.len(rName))
                    rName = "..." .. rName
                end
                return "%#file#" .. " " .. icon .. " " .. rName
            end,
        },
    },
}

return M
