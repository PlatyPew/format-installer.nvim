local M = {}

function M.install(path)
    vim.fn.system({ 'python3', '-m', 'venv', path })
    vim.fn.system({ path .. '/bin/pip3', 'install', '-U', 'yapf' })
end

function M.get_path(path)
    return path .. '/bin/yapf'
end

return M
