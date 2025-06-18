return {

    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     event = { "BufReadPre", "BufNewFile" },
    --     config = function()
    --         require("configs.treesitter")
    --     end,
    -- },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require("configs.treesitter-context")
                end,
            },
            {
                "abecodes/tabout.nvim",
                event = "InsertEnter",
                config = function()
                    require("configs.tabout")
                end,
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
    -- https://github.com/mason-org/mason.nvim/issues/1421
    -- GOOS=darwin GOARCH=arm64 nvim
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        -- enabled = false,
        opts = require("configs.tree"),
    },
    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            return { override = require("nvchad.icons.devicons") }
        end,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "devicons")
            require("nvim-web-devicons").setup(opts)
        end,
    },

    -- brew install ripgrep
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        opts = require("configs.telescope"),
    },

    -- brew install ctags
    {
        "preservim/tagbar",
        lazy = false,
    },

    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<Down>"] = cmp.mapping.select_next_item(),
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = require("configs.gitsigns"),
    },
}
