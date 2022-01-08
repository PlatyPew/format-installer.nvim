# About

A lightweight installer plugin written for [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) used to manage formatters

Formatters are installed locally into `stdpath("data")`

Created because I couldn't find anyone else who has done it yet

Very very VERY WIP

# Installation

Via packer

```lua
use 'PlatyPew/format-installer.nvim'
```

Setup (You don't have to run this if you don't want to change the installation path)

```lua
-- defaults
require'format-installer'.setup{
    installation_path = vim.fn.stdpath('data') .. '/formatters/', -- change path to suit your needs
}
```

# Usage

`:FInstall <fomatter>` to install formatters
`:FUninstall <fomatter>` to uninstall formatters

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

null_ls.setup{
    sources = sources,
}
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
table.insert(
    sources,
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--column-width=100", "--indent-type=Spaces" },
    })
)
```

# Installers

| Formatter    | Dependencies    |
| ------------ | --------------- |
| clang_format | llvm            |
| shfmt        | curl            |
| prettier     | npm             |
| yapf         | pip, virutalenv |

# Lua API

-   `require'format-installer'.setup()`
-   `require'format-installer'.install_formatter(<formatter>)`
-   `require'format-installer'.uninstall_formatter(<formatter>)`
-   `require'format-installer'.get_installed_formatters()`
