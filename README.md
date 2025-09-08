# Установка и настройка конфигурации nvim

## Настройка Golang

Установить пакеты для форматирования кода

```
 go install mvdan.cc/gofumpt@latest

```

```
go install github.com/incu6us/goimports-reviser/v3@latest
```

```
go install github.com/segmentio/golines@latest
```

## Bootstrap / первый запуск

1. Установить системные утилиты:
   - **ripgrep** (`rg`) — для `live_grep`
   - **fd** — для быстрого поиска файлов в Telescope
   - (Go) `go` и инструменты из `mason-tool-installer` поставятся сами
   - (Rust) `rustup`, `cargo`
   - (.NET) `dotnet` SDK (для тестов и сборки)

2. В Neovim:

   ```markdown
   :Lazy! sync
   :MasonToolsInstall
   :TSUpdate
   ```

3. Тесты (необязательно, но удобно):
- Go: `go test ./...`
- Rust: `cargo test`
- .NET: `dotnet test`

## Быстрые хоткеи

- **Tasks (Overseer):**
- `<leader>tr` — запустить задачу
- `<leader>tt` — список задач
- **Tests (neotest):**
- `<leader>tn` — ближайший тест
- `<leader>tf` — тесты файла
- `<leader>tp` — тесты проекта
- `<leader>to` — открыть вывод
- `<leader>ts` — сводка
- **Debug (DAP):**
- `<F5>`/`<F10>`/`<F11>`/`<S-F11>` — запуск/шаги
- `<leader>db` — breakpoint
- `<leader>du` — DAP UI
