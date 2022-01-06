local M = {}

local settings = {
    installation_path = vim.fn.stdpath('data') .. '/formatters/',
}

local configs = 'format-installer/formatters/'

function M.setup(opts)
    if opts and opts.installation_path then
        settings.installation_path = opts.installation_path
    end
end

function M.install_formatter(formatter)
    if vim.fn.isdirectory(settings.installation_path) == 0 then
        vim.fn.mkdir(settings.installation_path)
    end

    require(configs .. formatter).install(settings.installation_path .. formatter)
    print(formatter .. ' installed!')
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
