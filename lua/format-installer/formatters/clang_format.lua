local M = {}

function M.install(path)
    local clang_format_path = vim.fn.exepath('clang-format')
    vim.fn.mkdir(path)
    vim.fn.system({ 'ln', '-sf', clang_format_path, path .. '/clang-format' })
end

function M.get_path(path)
    return path .. '/clang-format'
end

return M
