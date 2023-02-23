---
title: "Minimal Setup: Configuring Rust Debugger in Neovim"
date: 2023-02-20T22:56:10+02:00
tags: [nvim, rust]
---
### Prerequirements
- You know how to setup and configure neovim plugins.
- You use UNIX-like OS

### Step-by-Step guide
1. Install the next neovim plugins
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)

```lua
-- Example with packer.nvim 
use("mfussenegger/nvim-dap")
use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
```
2. Install vscode-lldb
    1. Download file specific to your system https://github.com/vadimcn/vscode-lldb/releases
    2. Unpack it by `unzip` utility. In my case I unpacked it to `~/Sources/lldb`
    The result of execution `unzip codelldb-x86_64-linux.vsix` in `~/Sources/lldb`:
    ![img](/images/rust_neovim_debug1.png)
    3. codelldb execution file is available by path: `~/Sources/lldb/extension/adapter`

3. Configure nvim-dap in your `init.lua`

```lua
local dap = require("dap")

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- Change this to your path!
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

4. Open any rust program and execute in neovim command line `:lua require("dap").toggle_breakpoint()` where you can stop your program
{{<details  "Screenshot">}}![img](/images/rust_neovim_debug2.png){{</details>}}
5. Run `:lua require("dap").continue()` in neovim command line to start debugging  
{{<details  "Screenshot">}}![img](/images/rust_neovim_debug3.png){{</details>}}
6. Run `:lua require("dapui").open()`  
{{<details  "Screenshot">}}![img](/images/rust_neovim_debug4.png){{</details>}}
You can navigate through debug windows by mouse.  
Execte `:lua require("dapui").close()` - to close all debug windows

### Additional info
You can find at plugins repositories [nvim-dap](https://github.com/mfussenegger/nvim-dap) and [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)

P.S. I like the idea of float elements  
Example: `:lua require("dapui").float_element('scopes', { enter = true })`  
{{<details  "Screenshot">}}![img](/images/rust_neovim_debug5.png){{</details>}}
