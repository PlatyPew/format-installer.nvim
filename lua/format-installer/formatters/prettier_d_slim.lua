local M = {}

function M.install(path, formatter)
    M.dependencies = { "npm" }
    if vim.fn.executable(M.dependencies[1]) == 1 then
        vim.fn.system({ M.dependencies[1], "install", "--prefix", path, "prettier_d_slim" })
        return true
    else
        print("Failed to install " .. formatter .. "! Missing dependencies: " .. M.dependencies[1])
        return false
    end
end

function M.get_path(path)
    return path .. "/node_modules/.bin/prettier_d_slim"
end

return M
