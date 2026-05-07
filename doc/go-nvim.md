# go.nvim 集成说明（与本配置共存）

插件仓库：<https://github.com/ray-x/go.nvim>

## 与现有工具的分工

| 能力 | 由谁负责 | 说明 |
|------|-----------|------|
| **gopls / LSP** | `lua/configs/lspconfig.lua` | `go.nvim` 已设置 `lsp_cfg = false`，不会重复启动或覆盖 gopls |
| **保存时格式化** | `conform.nvim`（`lua/configs/conform.lua`） | `lsp_document_formatting = false`，不要用 `:GoFmt` 替代整套 conform 链，除非临时手动 |
| **Lint** | `nvim-lint` + `golangci-lint`（`lua/configs/lint.lua`） | `golangci_lint.default = "none"`，避免与 `nvim-lint` 重复一套 golangci 策略；需要时用 `:GoLint` 可作为补充 |
| **诊断样式** | `lua/configs/lspconfig.lua` 里的 `vim.diagnostic.config` | `diagnostic = false`，不把诊断 UI 交给 go.nvim 覆盖 |

其它：`lsp_keymaps = false`（避免与 NvChad / 自带 LSP 映射冲突）、`textobjects = false`（沿用 `nvim-treesitter-textobjects`）、`lsp_inlay_hints.enable = false`（沿用你在 gopls 里的 inlay 配置）、`dap_debug_keymap = false`（避免在未装 DAP 时占键；需要时可改为 `true` 并安装 `nvim-dap`）。

## 可选：安装/更新 go.nvim 依赖的二进制

部分命令依赖 `gomodifytags`、`gotests`、`dlv` 等，可在 Neovim 中执行：

```vim
:GoInstallBinaries
" 或更新
:GoUpdateBinaries
```

首次可在 lazy 插件里加 `build`（见下），或手动执行上述命令。

## 快捷键（Normal，buffer：go / gomod）

前缀均为 **`<leader>go`**（`<leader>` 默认为空格时为 ` go…`）。

| 按键 | 命令 | 说明 |
|------|------|------|
| `<leader>goa` | `GoAlt!` | 在实现文件与 `_test.go` 等之间切换 |
| `<leader>goi` | `GoIfErr` | 生成 `if err != nil` 等 |
| `<leader>gos` | `GoFillStruct` | 填充结构体字段 |
| `<leader>gom` | `GoModTidy` | `go mod tidy` |
| `<leader>got` | `GoTest` | 运行测试 |
| `<leader>gou` | `GoTestFunc` | 光标下测试函数 |
| `<leader>goc` | `GoCmt` | 生成文档注释 |
| `<leader>gop` | `GoPkgOutline` | 包大纲 |
| `<leader>god` | `GoDoc` | 文档浮窗 |

更多命令见上游 `:Go*` 补全或仓库 [commands.lua](https://github.com/ray-x/go.nvim/blob/master/lua/go/commands.lua)。

## 项目级覆盖（可选）

在仓库根目录放 `.gonvim/init.lua`，`return { ... }` 可覆盖 `go.setup()` 选项（详见 go.nvim README）。

## 故障排查

- **命令不存在**：确认 `lazy` 已加载 `ray-x/go.nvim`，且当前 `filetype` 为 `go` / `gomod`。
- **某命令提示缺工具**：`:GoInstallBinaries`，并保证 `$GOPATH/bin` 在 `PATH` 中。
- **与格式化/LSP 打架**：确认未在其他位置启用 `go.nvim` 的 `lsp_cfg` / 保存时 `:GoFmt`。
