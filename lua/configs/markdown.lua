local present, render_md = pcall(require, "render-markdown")

if not present then
    return
end

---@type render.md.UserConfig
render_md.setup({
    completions = { lsp = { enabled = true } },
    anti_conceal = { enabled = true },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
        vim.keymap.set(
            "n",
            "<leader>mr",
            "<cmd>RenderMarkdown toggle<cr>",
            { buffer = args.buf, desc = "Toggle markdown render" }
        )
    end,
})
