-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "everblush",
    hl_override = {
        CursorLine = { bg = "#888888" },
        Visual = { bg = "#888888" },
        CursorLineNr = { bg = "#f1c40f" },
        NvimTreeCursorLine = { bg = "#888888" },
    },
}

return M
