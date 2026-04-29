local function on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
    vim.keymap.set("n", "_", api.node.open.horizontal, opts("Open: Horizontal Split"))
    vim.keymap.set("n", "+", api.node.open.vertical, opts("Open: Vertical Split"))
end

local options = {
    on_attach = on_attach,

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
