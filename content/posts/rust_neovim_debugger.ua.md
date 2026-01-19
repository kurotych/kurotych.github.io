---
title: "Мінімальне налаштування: конфігурація Rust дебагера в Neovim"
date: 2023-02-20T22:56:10+02:00
tags: [nvim, rust]
---
### Передумови
- Ви знаєте, як налаштовувати та конфігурувати плагіни neovim.
- Ви використовуєте UNIX-подібну ОС

### Покрокова інструкція
1. Встановіть наступні плагіни neovim
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)

```lua
-- Приклад з packer.nvim
use("mfussenegger/nvim-dap")
use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
```
2. Встановіть vscode-lldb
    1. Завантажте файл, специфічний для вашої системи https://github.com/vadimcn/vscode-lldb/releases
    2. Розпакуйте його утилітою `unzip`. У моєму випадку я розпакував у `~/Sources/lldb`
    Результат виконання `unzip codelldb-x86_64-linux.vsix` у `~/Sources/lldb`:
    ![img](/images/rust_neovim_debug1.png)
    3. Виконуваний файл codelldb доступний за шляхом: `~/Sources/lldb/extension/adapter`

3. Налаштуйте nvim-dap у вашому `init.lua`

```lua
local dap = require("dap")

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- Змініть це на ваш шлях!
    command = '/home/kurotych/Sources/lldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.rust= {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

require("dapui").setup({})
```

4. Відкрийте будь-яку rust програму та виконайте в командному рядку neovim `:lua require("dap").toggle_breakpoint()` там, де хочете зупинити програму
{{<details  "Скріншот">}}![img](/images/rust_neovim_debug2.png){{</details>}}
5. Запустіть `:lua require("dap").continue()` у командному рядку neovim для початку відладки
{{<details  "Скріншот">}}![img](/images/rust_neovim_debug3.png){{</details>}}
6. Запустіть `:lua require("dapui").open()`
{{<details  "Скріншот">}}![img](/images/rust_neovim_debug4.png){{</details>}}
Ви можете переміщатися по вікнах відладки за допомогою миші.
Виконайте `:lua require("dapui").close()` - щоб закрити всі вікна відладки

### Гарячі клавіші
```lua
local dap = require('dap')
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set('n', '<Leader>df', function() require("dapui").float_element('scopes', { enter = true }) end)
```

### Додаткова інформація
Ви можете знайти у репозиторіях плагінів [nvim-dap](https://github.com/mfussenegger/nvim-dap) та [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)

{{<details  "Скріншот dapui float_element">}}![img](/images/rust_neovim_debug5.png){{</details>}}
