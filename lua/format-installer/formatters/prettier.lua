local M = {}

function M.install(path)
    vim.fn.system({ 'npm', 'install', '--prefix', path, 'prettier' })
end

function M.get_path(path)
    return path .. '/node_modules/.bin/prettier'
end

return M
