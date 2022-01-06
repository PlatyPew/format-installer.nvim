local M = {}

local settings = {
    installation_path = vim.fn.stdpath('data') .. '/formatters/',
}

function M.setup(opts)
    if opts.installation_path then
        settings.installation_path = opts.installation_path
    end
end


return {
    setup = M.setup,
}
