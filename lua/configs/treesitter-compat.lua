-- Neovim 0.12+ passes capture tables as TSNode[] (list per capture id).
-- nvim-treesitter query_predicates still assume a single TSNode; that breaks
-- markdown injections (render-markdown, highlights) with:
--   get_node_text -> get_range -> node:range on a table / nil.
-- Re-register affected handlers after nvim-treesitter (force = true).

local query = require("vim.treesitter.query")

local html_script_type_languages = {
    ["importmap"] = "json",
    ["module"] = "javascript",
    ["application/ecmascript"] = "javascript",
    ["text/ecmascript"] = "javascript",
}

local non_filetype_match_injection_language_aliases = {
    ex = "elixir",
    pl = "perl",
    sh = "bash",
    uxn = "uxntal",
    ts = "typescript",
}

local function get_parser_from_markdown_info_string(injection_alias)
    local match_ft = vim.filetype.match({ filename = "a." .. injection_alias })
    return match_ft or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
end

local function error_msg(str)
    vim.api.nvim_err_writeln(str)
end

local function valid_args(name, pred, count, strict_count)
    local arg_count = #pred - 1
    if strict_count then
        if arg_count ~= count then
            error_msg(string.format("%s must have exactly %d arguments", name, count))
            return false
        end
    elseif arg_count < count then
        error_msg(string.format("%s must have at least %d arguments", name, count))
        return false
    end
    return true
end

---@param match table
---@param id integer|string
---@return TSNode|nil
local function cap_node(match, id)
    local cap = match[id]
    if cap == nil then
        return nil
    end
    if type(cap) == "table" then
        local n = cap[#cap]
        return n
    end
    return cap
end

local opts = vim.fn.has("nvim-0.10") == 1 and { force = true, all = false } or true

query.add_predicate("nth?", function(match, _pattern, _bufnr, pred)
    if not valid_args("nth?", pred, 2, true) then
        return
    end
    local node = cap_node(match, pred[2])
    local n = tonumber(pred[3])
    if node and node:parent() and node:parent():named_child_count() > n then
        return node:parent():named_child(n) == node
    end
    return false
end, opts)

query.add_predicate("is?", function(match, _pattern, bufnr, pred)
    if not valid_args("is?", pred, 2) then
        return
    end
    local locals = require("nvim-treesitter.locals")
    local node = cap_node(match, pred[2])
    local types = { unpack(pred, 3) }
    if not node then
        return true
    end
    local _, _, kind = locals.find_definition(node, bufnr)
    return vim.tbl_contains(types, kind)
end, opts)

query.add_predicate("kind-eq?", function(match, _pattern, _bufnr, pred)
    if not valid_args(pred[1], pred, 2) then
        return
    end
    local node = cap_node(match, pred[2])
    local types = { unpack(pred, 3) }
    if not node then
        return true
    end
    return vim.tbl_contains(types, node:type())
end, opts)

query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local capture_id = pred[2]
    local node = cap_node(match, capture_id)
    if not node then
        return
    end
    local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[type_attr_value]
    if configured then
        metadata["injection.language"] = configured
    else
        local parts = vim.split(type_attr_value, "/", {})
        metadata["injection.language"] = parts[#parts]
    end
end, opts)

query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local capture_id = pred[2]
    local node = cap_node(match, capture_id)
    if not node then
        return
    end
    local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
end, opts)

query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = cap_node(match, id)
    if not node then
        return
    end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then
        metadata[id] = {}
    end
    metadata[id].text = string.lower(text)
end, opts)
