local M = {}

function M.install(path, formatter)
    M.dependencies = { "npm" }
    if vim.fn.executable(M.dependencies[1]) == 1 then
        vim.fn.system({ M.dependencies[1], "install", "--prefix", path, "eslint" })
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
    return path .. "/node_modules/.bin/eslint"
end

return M
