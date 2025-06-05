local options = {
    ensure_installed = {
        "bash",
        -- "c",
        -- "cmake",
        -- "cpp",
        "fish",

        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",

        -- "haskell",
        "lua",
        "luadoc",
        -- "make",
        "markdown",
        -- "odin",
        "printf",
        -- "python",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },

    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- vaf: 选中整个函数
                ["af"] = "@function.outer",
                -- vif: 选择函数体，不包括函数名
                ["if"] = "@function.inner",
                -- vac: 选中整个类定义(struct)
                ["ac"] = "@class.outer",
                -- vic: 选中整个类定体，不包含类名，但是包含大括号(struct)
                ["ic"] = "@class.inner",
                -- vaa: 选中当前参数，包含逗号
                ["aa"] = "@parameter.outer",
                -- via: 选中当前参数，不包含逗号
                ["ia"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            -- 光标调到下一个函数声明处
            goto_next_start = {
                ["]]"] = "@function.outer",
            },
            -- 光标调到上一个函数声明处
            goto_previous_start = {
                ["[["] = "@function.outer",
            },
        },
    },
}

require("nvim-treesitter.configs").setup(options)
