# About

### Caution: Development may terminate at any moment without prior warning, feel free to fork :)

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
-- Custom configs to pass
local custom_configs = {
    clang_format = {
        extra_args = {
            "--style",
            "{IndentWidth: 4, PointerAlignment: Left, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: Empty}",
        },
    },
    prettier = {
        extra_args = {
            "--tab-width=4",
            "--print-width=100",
        },
    },
    stylua = {
        extra_args = {
            "--column-width=100",
            "--indent-type=Spaces",
        },
    },
    yapf = {
        extra_args = {
            "--style",
            "{column_limit:100}",
        },
    },
}

local sources = {}
for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
    local config = { command = formatter.cmd }
    if custom_configs[formatter.name] ~= nil then
        config.extra_args = custom_configs[formatter.name].extra_args
    end
    table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
end

-- Optional: Additional formatters/diagnostics that are not included
-- This just uses the null-ls defaults
table.insert(
    sources,
    null_ls.builtins.code_actions.gitsigns,
)
```

# Formatters available

| Formatter              | Dependencies | Version |
| ---------------------- | ------------ | ------- |
| asmfmt                 | curl, tar    | 1.3.2   |
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
| google_java_format     | curl, java   | 1.15.0  |
| isort                  | virtualenv   |
| markdownlint           | npm          |
| mypy                   | virtualenv   |
| nginx_beautifier       | npm          |
| prettier               | npm          |
| prettier_d_slim        | npm          |
| prettier_standard      | npm          |
| prettierd              | npm          |
| reorder_python_imports | virtualenv   |
| rustfmt                | curl, tar    | 1.5.1   |
| shfmt                  | curl         | 3.5.1   |
| stylelint              | npm          |
| stylua                 | curl, unzip  | 1.13.1  |
| trim_newlines          | awk          |
| yapf                   | virtualenv   |

# Lua API

-   `require'format-installer'.setup()` - Setups the installation path
-   `require'format-installer'.install_formatter(<formatter>)` - Installs formatter
-   `require'format-installer'.uninstall_formatter(<formatter>)` - Uninstalls formatter
-   `require'format-installer'.get_installed_formatters()` - Returns a table of installed formatters
-   `require'format-installer'.exists(<formatter>)` - Returns boolean if formatter exists
-   `require'format-installer'.is_installed(<formatter>)` - Returns boolean if formatter is installed
