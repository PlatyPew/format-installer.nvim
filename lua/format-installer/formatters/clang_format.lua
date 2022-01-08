local M = {}

function M.install(path)
    if vim.fn.executable("clang-format") == 1 then
        local clang_format_path = vim.fn.exepath("clang-format")
        vim.fn.mkdir(path)
        vim.fn.system({ "ln", "-sf", clang_format_path, path .. "/clang-format" })
        return true
    else
        print("Failed to install clang_format! Missing dependencies: llvm")
        return false
    end
end

function M.get_path(path)
    return path .. "/clang-format"
end

return M
