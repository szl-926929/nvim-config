local options = {
    -- log_level = vim.log.levels.TRACE,
    formatters_by_ft = {
        lua = { "stylua" },
        -- c = { "clang-format" },
        -- cpp = { "clang-format" },
        -- go = { "gofumpt", "goimports-reviser", "golines", "goimports" },
        -- gofumpt (style) → goimports-reviser (imports) → golines (line length) last
        go = { "gofumpt", "goimports-reviser", "golines" },
        markdown = { "prettier" },
        -- haskell = { "fourmolu", "stylish-haskell" },
        -- python = { "isort", "black" },
    },

    formatters = {
        -- -- C & C++
        -- ["clang-format"] = {
        --     prepend_args = {
        --         "-style={ \
        --                 IndentWidth: 4, \
        --                 TabWidth: 4, \
        --                 UseTab: Never, \
        --                 AccessModifierOffset: 0, \
        --                 IndentAccessModifiers: true, \
        --                 PackConstructorInitializers: Never}",
        --     },
        -- },
        -- Golang
        ["goimports-reviser"] = {
            -- prepend_args = { "-rm-unused" },
            -- prepend_args = { "-format", "-rm-unused" },
            -- prepend_args = { "-rm-unused", "-set-alias", "-format" },
            prepend_args = { "-set-alias", "-format" },
        },
        golines = {
            -- prepend_args = { "--max-len=120" },
            prepend_args = { "--max-len=150" },
        },

        -- -- Lua
        -- stylua = {
        --     prepend_args = {
        --         "--column-width", "80",
        --         "--line-endings", "Unix",
        --         "--indent-type", "Spaces",
        --         "--indent-width", "4",
        --         "--quote-style", "AutoPreferDouble",
        --     },
        -- },
        -- -- Python
        -- black = {
        --     prepend_args = {
        --         "--fast",
        --         "--line-length",
        --         "80",
        --     },
        -- },
        -- isort = {
        --     prepend_args = {
        --         "--profile",
        --         "black",
        --     },
        -- },
    },

    -- format_on_save runs in BufWritePre and blocks until all formatters finish (feels laggy).
    -- format_after_save runs async after write, then :update — UI stays responsive.
    format_after_save = {
        timeout_ms = 15000,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
