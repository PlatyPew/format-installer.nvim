local M = {}

function M.install(path, formatter)
    M.dependencies = { "llvm" }
    if vim.fn.executable("clang-format") == 1 then
        local clang_format_path = vim.fn.exepath("clang-format")
        vim.fn.mkdir(path)
        vim.fn.system({ "ln", "-sf", clang_format_path, path .. "/clang-format" })
        return true
    else
        print(
            string.format(
                "Failed to install %s! Missing dependencies: %s",
                formatter,
                M.dependencies[1]
            )
        )
        return false
    end
end

function M.get_path(path)
    return path .. "/clang-format"
end

return M
