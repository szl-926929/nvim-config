local lint = require("lint")

lint.linters_by_ft = {
    lua = { "selene" },
    go = { "golangcilint" },
    -- haskell = { "hlint" },
    python = { "flake8" },
}

--- Module root (directory containing go.mod) for the current buffer path.
--- Wrong cwd often makes golangci-lint exit with code 3 (failure), not diagnostics.
local function go_lint_cwd()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
        return nil
    end
    local dir = vim.fs.dirname(vim.fn.fnamemodify(path, ":p"))
    return vim.fs.root(dir, function(name)
        return name == "go.mod"
    end)
end

local function run_lint_for_current_buf()
    if vim.bo.filetype == "go" then
        local root = go_lint_cwd()
        if root then
            lint.try_lint(nil, { cwd = root })
            return
        end
    end
    lint.try_lint()
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function(args)
        -- Defer lint on save so :w returns immediately; golangci-lint still starts right after.
        if args.event == "BufWritePost" then
            local bufnr = args.buf
            vim.defer_fn(function()
                if not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end
                vim.api.nvim_buf_call(bufnr, run_lint_for_current_buf)
            end, 0)
            return
        end
        run_lint_for_current_buf()
    end,
})
