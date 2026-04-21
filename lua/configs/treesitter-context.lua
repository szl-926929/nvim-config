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
    -- Markdown (esp. injections like markdown_inline) can yield empty TS match
    -- lists; nvim-treesitter-context then calls :range() on nil (Neovim 0.10+
    -- iter_matches shape). Skip context for these buffers.
    on_attach = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "markdown" then
            return false
        end
    end,
})
