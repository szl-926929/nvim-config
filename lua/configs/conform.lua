local options = {
    -- log_level = vim.log.levels.TRACE,
    formatters_by_ft = {
        lua = { "stylua" },
        -- c = { "clang-format" },
        -- cpp = { "clang-format" },
        -- go = { "gofumpt", "goimports-reviser", "golines", "goimports" },
        go = { "gofumpt", "golines", "goimports-reviser" },
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

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 10000,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
