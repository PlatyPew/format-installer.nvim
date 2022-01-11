# About

### Caution: Still a work in progress

A lightweight installer plugin written for [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) used to manage formatters

Formatters are installed locally into `vim.fn.stdpath("data") .. "/formatters"` (it's usually located at `~/.local/share/nvim/formatters`)

Created because I couldn't find anyone else who has done it yet. Feel free to send issues, pull requests. All help will be greatly appreciated!

Also, there's no Windows support, but I am open to pull requests

# Installation

Via packer

```lua
use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = "PlatyPew/format-installer.nvim",
    after = "nvim-lspconfig", -- To prevent null-ls from failing to read buffer
})
```

Setup (Unnecessary if you don't want to change the installation path)

```lua
-- defaults
require("format-installer").setup({
    -- change path to suit your needs
    installation_path = vim.fn.stdpath('data') .. '/formatters/',
})
```

# Usage

`:FInstall <fomatter>` to install formatters

`:FUninstall <fomatter>` to uninstall formatters

`:FList` to list installed formatters

_You will need to restart Neovim for the formatters to take effect._

# Configuration with null-ls

This should be used in tandem with null-ls

```lua
local null_ls = require'null-ls'
local formatter_install = require'format-installer'

local sources = {}
for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
    local config = { command = formatter.cmd }
    table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
end

null_ls.setup({
    sources = sources,
})
```

What if I want to customise the args?

```lua
local sources = {}
for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
    local config = { command = formatter.cmd }

    -- Passes extra_args into null-ls configurations
    if formatter.name == 'clang_format' then
        config['extra_args'] = { '--style', '{IndentWidth: 4, PointerAlignment: Left, ColumnLimit: 100}' }
    elseif formatter.name == 'prettier' then
        config['extra_args'] = { '--tab-width=4', '--print-width=100' }
    end

    table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
end

-- Optional: Additional formatters that are not included
-- This just uses the null-ls defaults
table.insert(
    sources,
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--column-width=100", "--indent-type=Spaces" },
    })
)
```

# Formatters available

| Formatter              | Dependencies |
| ---------------------- | ------------ |
| autopep8               | virtualenv   |
| black                  | virtualenv   |
| clang_format           | llvm         |
| cmake_format           | virtualenv   |
| codespell              | virtualenv   |
| djhtml                 | virtualenv   |
| eslint                 | npm          |
| eslint_d               | npm          |
| fixjson                | npm          |
| fprettify              | virtualenv   |
| google_java_format     | curl, java   |
| isort                  | virtualenv   |
| markdownlint           | npm          |
| mypy                   | virtualenv   |
| nginx_beautifier       | npm          |
| prettier               | npm          |
| prettier_d_slim        | npm          |
| prettier_standard      | npm          |
| prettierd              | npm          |
| reorder_python_imports | virtualenv   |
| shfmt                  | curl         |
| stylua                 | curl, unzip  |
| yapf                   | virtualenv   |

# Lua API

-   `require'format-installer'.setup()`
-   `require'format-installer'.install_formatter(<formatter>)`
-   `require'format-installer'.uninstall_formatter(<formatter>)`
-   `require'format-installer'.get_installed_formatters()`
