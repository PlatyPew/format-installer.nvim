local M = {}

function M.install(path, formatter)
    M.dependencies = { "virtualenv" }
    if vim.fn.executable(M.dependencies[1]) == 1 then
        vim.fn.system({ M.dependencies[1], path })
        vim.fn.system({ path .. "/bin/pip3", "install", "-U", "cmakelang" })
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
    return path .. "/bin/cmake-format"
end

return M
