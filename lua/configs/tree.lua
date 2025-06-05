local options = {
    -- 关闭文件时自动关闭
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },

    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        highlight_git = false,
        icons = {
            show = {
                git = true,
            },
        },
    },
    update_cwd = true,
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
    },
}

return options
