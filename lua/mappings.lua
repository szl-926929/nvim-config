require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- 输入模式下：
-- ctrl-b：行头
-- ctrl-e: 行尾
--

----------------------
--theme
----------------------
---<leader> + th: 切换theme

----------------------
--treesitter
----------------------
-- vaf: 选中整个函数
-- vif: 选择函数体，不包括函数名
-- vac: 选中整个类定义(struct)
-- vic: 选中整个类定体，不包含类名，但是包含大括号(struct)
-- vaa: 选中当前参数，包含逗号
-- via: 选中当前参数，不包含逗号
-- ]]: 光标调到下一个函数声明处
-- [[: 光标调到上一个函数声明处

----------------------
--lsp
----------------------
-- K: 显示文档，再次K，进入文档窗口中，q退出
-- gD: 跳转到声明
-- gd：跳转到定义
-- gi: 查找接口的实现
-- <leader>ra: 一建修改类型名和所有调用的地方，会在bar标签中打开所有修改的文件
-- gr: 列出调用的地方
-- <leader>d: focus diagnostic, 主要是lint错误信息框
-- ctrl+w: 光标切出diagnostic
-- <leader>h：水平终端, esc: ctrl+w，切出终端
-- <leader>z：vim窗口全屏
-- <leader>q: 展示lint提示列表
-- [d: 上一个lint提示
-- ]d: 下一个lint提示
-- <leader>x: 关闭当前tabuf
map("n", "gr", function()
    vim.lsp.buf.references()
end, { desc = "LSP references" })

map("n", "gi", function()
    vim.lsp.buf.implementation()
end, { desc = "LSP implementation" })

-- normal模式下：
-- ctrl-s: 保持整个文件
-- ctrl-c: 拷贝整个文件
-- <leader>n: 显示/隐藏行号
-- <leader>rn: 相对行号
-- <leader>fm: 格式化代码

----------------------
--nvim-tree
----------------------
-- :sp：水平分割窗口打开当前文件
-- :vsp：垂直窗口打开当前文件
-- :new 文件名 水平窗口打开新文件
-- :vnew 文件名 垂直窗口打开新文件
-- sf: 在目录中显示文件
-- t: 在table中打开文件
-- _: 水平分割显示文件
-- -: up到上一层
-- +: 垂直平分割显示文件
-- a: 创建文件
-- d: 删除文件
-- r: 文件重命名
-- u: 文件路径重命名
-- R: 刷新
-- c: 文档拷贝到粘贴板
-- P: Parent Directory
-- R: Refresh

map("n", "sf", function()
    local function starts_with(String, Start)
        return string.sub(String, 1, string.len(Start)) == Start
    end

    local cwd = vim.fn.getcwd()
    local cur_path = vim.fn.expand("%:p:h")
    local cur_file_path = vim.fn.expand("%:p")
    if starts_with(cur_path, cwd) then
        --require('nvim-tree.api').tree.toggle({path=cur_path, update_root=cwd})
        require("nvim-tree.api").tree.find_file({ open = true, focus = true, buf = cur_file_path, update_root = cwd })
    else
        --require('nvim-tree.api').tree.toggle({path=cur_path})
        require("nvim-tree.api").tree.find_file({
            open = true,
            focus = true,
            buf = cur_file_path,
            update_root = cur_path,
        })
    end
end, { desc = "show file in tree" })

map("n", "t", function()
    local api = require("nvim-tree.api")
    api.node.open.tab()
end, { desc = "opened in a new tab" })

map("n", "_", function()
    local api = require("nvim-tree.api")
    api.node.open.horizontal()
end, { desc = "Open: Horizontal Split" })

map("n", "+", function()
    local api = require("nvim-tree.api")
    api.node.open.vertical()
end, { desc = "Open: Horizontal Split" })

map("n", "<leader>t", ":NvimTreeResize ", { desc = "resize tree xxx" })
map("n", "tl", "<cmd>NvimTreeResize +10<CR>", { desc = "nvimtree resize +10" })
map("n", "th", "<cmd>NvimTreeResize -10<CR>", { desc = "nvimtree resize -10" })

----------------------
--tab页
----------------------
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "focus diagnostic" })
map("n", "tc", "<cmd>tabc<CR>", { desc = "close current tab" })
map("n", "t1", "<cmd>tabnext 1<CR>", { desc = "choose 1 tab" })
map("n", "t2", "<cmd>tabnext 2<CR>", { desc = "choose 2 tab" })
map("n", "t3", "<cmd>tabnext 3<CR>", { desc = "choose 3 tab" })
map("n", "t4", "<cmd>tabnext 4<CR>", { desc = "choose 4 tab" })
map("n", "<leader>c", "<cmd>cclose<CR>", { desc = "close quickfix" })

----------------------
--telescope
-- esc: 进入normal模式
--normal模式下，f/d: 滚动显示搜索的view内容
-- <C-c>: insert mode，直接关闭telescope
-- <C-q>: 在quickfix窗口显示
-- <M-q>: 在quickfix窗口显示选中的文件列表
----------------------
map("n", "<C-p>", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", ";fd", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fs", "<cmd> Telescope lsp_document_symbols symbol_width=50 <CR>", { desc = "lsp document symbols" })

----------------------
-- tagbar
----------------------
-- 小p：显示tag的内容，但是不离开tagbar窗口
-- enter：显示tag的内容，光标并移到内容处
-- 大P：在顶部的preview窗口显示
-- <C-N>：跳转到下一个top-level的tag
-- <C-P>：跳转到上一个top-level的tag
-- <space>：显示声明
-- za: 展开/折叠 tag
-- =：折叠所有 tag
-- *：展开所有tag

map("n", "<F8>", "<cmd>TagbarToggle<CR>", { desc = "open tagbar" })
