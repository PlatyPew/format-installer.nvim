local M = {}

local settings = {
    installation_path = vim.fn.stdpath("data") .. "/formatters/",
}

local configs = "format-installer/formatters/"

FORMATTERS = {
    "autopep8",
    "black",
    "clang_format",
    "cmake_format",
    "codespell",
    "djhtml",
    "eslint",
    "eslint_d",
    "fixjson",
    "fprettify",
    "google_java_format",
    "isort",
    "markdownlint",
    "mypy",
    "nginx_beautifier",
    "prettier",
    "prettier_d_slim",
    "prettier_standard",
    "prettierd",
    "reorder_python_imports",
    "rustywind",
    "shfmt",
    "stylelint",
    "stylua",
    "yapf",
}

function M.setup(opts)
    if opts and opts.installation_path then
        settings.installation_path = opts.installation_path
    end
end

function M.install_formatter(formatter)
    if vim.fn.isdirectory(settings.installation_path) == 0 then
        vim.fn.mkdir(settings.installation_path)
    end

    if vim.fn.isdirectory(settings.installation_path .. formatter) ~= 0 then
        print("Formatter already installed")
    else
        if vim.tbl_contains(FORMATTERS, formatter) then
            if
                require(configs .. formatter).install(
                    settings.installation_path .. formatter,
                    formatter
                )
            then
                print("Installed " .. formatter)
            end
        else
            print("Formatter does not exist!")
        end
    end
end

function M.uninstall_formatter(formatter)
    if
        vim.tbl_contains(FORMATTERS, formatter)
        and vim.fn.isdirectory(settings.installation_path .. formatter) ~= 0
    then
        vim.fn.delete(settings.installation_path .. formatter, "rf")
        print("Uninstalled " .. formatter)
    else
        print("Formatter not installed!")
    end
end

function M.get_installed_formatters()
    local formatters = {}

    local installed = vim.fn.globpath(settings.installation_path, "*", 0, 1)
    for _, v in ipairs(installed) do
        local formatter = v:match("^.+/(.+)$")
        local cmd = require(configs .. formatter).get_path(settings.installation_path .. formatter)
        table.insert(formatters, {
            name = formatter,
            cmd = cmd,
        })
    end

    return formatters
end

function _G.get_available_formatters()
    return table.concat(FORMATTERS, "\n")
end

function _G.get_installed_formatters()
    local formatters = {}
    for _, formatter in ipairs(M.get_installed_formatters()) do
        table.insert(formatters, formatter.name)
    end

    return table.concat(formatters, "\n")
end

vim.cmd([[
    command! -nargs=1 -complete=custom,v:lua.get_available_formatters FInstall call v:lua.require("format-installer").install_formatter(<f-args>)
    command! -nargs=1 -complete=custom,v:lua.get_installed_formatters FUninstall call v:lua.require("format-installer").uninstall_formatter(<f-args>)
    command! FList echo v:lua.get_installed_formatters()
]])

return M
