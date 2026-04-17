require("nvchad.options")

local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.swapfile = false

-- o.cursorlineopt ='both' -- to enable cursorline!

-- set filetype for .CBL COBOL files.
-- vim.cmd([[ au BufRead,BufNewFile *.CBL set filetype=cobol ]])

-- 只剩下tree的时候，关闭tree
vim.o.confirm = true
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
    callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if
            layout[1] == "leaf"
            and vim.bo[vim.api.nvim_win_get_buf(layout[2])].filetype == "NvimTree"
            and layout[3] == nil
        then
            vim.cmd("quit")
        end
    end,
})

local opt = vim.opt

opt.termguicolors = true

-- 代码折叠
-- za：打开或关闭当前折叠
-- zM: 折叠所有代码
-- zR: 展开所有折叠的代码
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Telescope 等异步打开文件时，treesitter 可能还未完成解析，
-- 需要在窗口显示 buffer 后重新触发折叠计算
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("FixTreesitterFolds", { clear = true }),
    callback = function()
        if vim.wo.foldmethod == "expr" then
            vim.schedule(function()
                vim.opt_local.foldmethod = "expr"
            end)
        end
    end,
})

-- 窗口变小不自动换行
opt.wrap = false

vim.o.cursorlineopt = "number,line"
vim.cmd([[set cursorcolumn]])
vim.cmd([[set cursorline]])

----------------------
-- tagbar
-- brew install ctags
-- echo  alias ctags="`brew --prefix`/bin/ctags" >> ~/.zshrc
-- go install github.com/jstemmer/gotags@latest
-- mkdir ~/.tmp/
----------------------
local cmd = vim.cmd
cmd([[let g:tagbar_ctags_bin='/opt/homebrew/bin/ctags']])
cmd([[let $TMPDIR=$HOME . '/.tmp']])

----------------------
-- statusline
----------------------
-- vim每个窗口都线上文件路径
vim.cmd([[set laststatus=2]]) -- 设置状态栏在倒数第2行
