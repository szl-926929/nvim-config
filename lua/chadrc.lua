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
        -- 查看某个配置的颜色值：:lua print(vim.fn.synIDattr(vim.fn.hlID("StatusLine"), "fg#"))
        StatusLine = { bold = true, underline = true, fg = "#e0e2ea", bg = "#4f5258" }, -- 设置状态栏前景色和背景色，同时添加粗体和下划线
        StatusLineNC = { bold = false, underline = false },
    },
}
-- vim.api.nvim_set_hl(0, "StatusLine", { cterm = "bold,underline", guifg = "NvimLightGrey2", guibg = "NvimDarkGrey4" }) -- 设置状态栏前景色和背景色

-- https://github.com/NvChad/ui/blob/v2.5/lua/nvchad/stl/utils.lua#L12
-- https://github.com/NvChad/NvChad/commit/cd5d85a11b5eecaf12d9a9f420e8924ed6a214d7#commitcomment-77606986
M.ui = {
    statusline = {
        separator_style = "round",
        theme = "default",
        order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "progress" },
        modules = {
            --- 文件内位置：行/总行 · 百分比（按行数）
            progress = function()
                local win = vim.g.statusline_winid
                if not win or win == 0 then
                    return ""
                end
                local buf = vim.api.nvim_win_get_buf(win)
                local cur = vim.api.nvim_win_get_cursor(win)[1]
                local total = math.max(1, vim.api.nvim_buf_line_count(buf))
                local pct = math.floor((cur * 100) / total + 0.5)
                pct = math.min(100, math.max(0, pct))
                return "%#St_pos_text# " .. cur .. "/" .. total .. " · " .. pct .. "%% "
            end,
            file = function()
                local icon = "󰈚"
                local bufnr = stbufnr()
                local path = vim.api.nvim_buf_get_name(bufnr)
                local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
                local project = vim.fn.getcwd()
                if string.sub(path, 1, #project) == project then
                    path = string.sub(path, #project + 1)
                end

                if name ~= "Empty " then
                    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

                    if devicons_present then
                        local ft_icon = devicons.get_icon(name)
                        icon = (ft_icon ~= nil and ft_icon) or icon
                    end
                end

                local maxLength = 53
                if string.len(path) > maxLength then
                    path = "…" .. string.sub(path, string.len(path) - maxLength + 4, string.len(path))
                end

                local modified = vim.bo[bufnr].modified and " [+]" or ""
                local readonly = vim.bo[bufnr].readonly and " [RO]" or ""
                return "%#file#" .. " " .. icon .. " " .. path .. modified .. readonly
            end,
        },
    },
}

return M
