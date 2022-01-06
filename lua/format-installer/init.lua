local M = {}

local settings = {
    installation_path = vim.fn.stdpath('data') .. '/formatters/',
}

local configs = 'format-installer/formatters/'

FORMATTERS = {
    'prettier',
    'yapf',
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
        print('Formatter already installed')
    else
        if vim.tbl_contains(FORMATTERS, formatter) then
            require(configs .. formatter).install(settings.installation_path .. formatter)
            print('Installed ' .. formatter)
        else
            print('Formatter does not exist!')
        end
    end
end

function M.uninstall_formatter(formatter)
    if vim.tbl_contains(FORMATTERS, formatter) and vim.fn.isdirectory(settings.installation_path .. formatter) ~= 0 then
        vim.fn.delete(settings.installation_path .. formatter, 'rf')
        print('Uninstalled ' .. formatter)
    else
        print('Formatter not installed!')
    end
end

function M.get_installed_formatters()
    local formatters = {}

    local installed = vim.fn.globpath(settings.installation_path, '*', 0, 1)
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

return M
