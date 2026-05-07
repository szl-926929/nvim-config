-- ray-x/go.nvim — 与现有栈共存：
-- · gopls：仅用 nvim-lspconfig（configs/lspconfig.lua），不用 go.nvim 自带 lsp_cfg
-- · 格式化：仅用 conform.nvim（configs/conform.lua）
-- · Lint：仅用 nvim-lint + golangci-lint（configs/lint.lua）
-- 详见 ../../doc/go-nvim.md

require("go").setup({
    lsp_cfg = false,
    lsp_keymaps = false,
    lsp_document_formatting = false,
    lsp_codelens = false,
    lsp_inlay_hints = { enable = false },
    lsp_gofumpt = false,
    diagnostic = false,
    null_ls_document_formatting_disable = true,
    textobjects = false,
    dap_debug_keymap = false,
    golangci_lint = { default = "none" },
})

-- 常用命令快捷键（仅 go / gomod 缓冲）；其余命令见 :help 或 doc/go-nvim.md
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod" },
    callback = function(args)
        local b = args.buf
        local map = function(mode, lhs, cmd, desc)
            vim.keymap.set(mode, lhs, "<cmd>" .. cmd .. "<cr>", { buffer = b, desc = desc })
        end
        map("n", "<leader>goa", "GoAlt!", "go.nvim: GoAlt (源码/测试切换)")
        map("n", "<leader>goi", "GoIfErr", "go.nvim: GoIfErr")
        map("n", "<leader>gos", "GoFillStruct", "go.nvim: GoFillStruct")
        map("n", "<leader>gom", "GoModTidy", "go.nvim: GoModTidy")
        map("n", "<leader>got", "GoTest", "go.nvim: GoTest")
        map("n", "<leader>gou", "GoTestFunc", "go.nvim: GoTestFunc")
        map("n", "<leader>goc", "GoCmt", "go.nvim: GoCmt 注释")
        map("n", "<leader>gop", "GoPkgOutline", "go.nvim: GoPkgOutline")
        map("n", "<leader>god", "GoDoc", "go.nvim: GoDoc")
    end,
})
