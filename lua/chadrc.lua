-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

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

return M
