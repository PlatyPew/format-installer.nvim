local M = {}

function M.install(path, formatter)
    M.dependencies = { "awk" }
    if vim.fn.executable(M.dependencies[1]) == 1 then
        local awk_path = vim.fn.exepath("awk")
        vim.fn.mkdir(path)
        vim.fn.system({ "ln", "-sf", awk_path, path .. "awk" })
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
    return path .. "/awk"
end

return M
