local present, ts_ctx = pcall(require, "treesitter-context")

if not present then
    return
end

ts_ctx.setup({
    enable = true,
    max_lines = 5,
    trim_scope = "outer",
    min_window_height = 0,
    zindex = 20,
    mode = "cursor",
    separator = nil,
})
