local M = {}

function M.install(path, formatter)
    local dependency = "npm"
    if vim.fn.executable(dependency) == 1 then
        vim.fn.system({ dependency, "install", "--prefix", path, "prettier" })
        return true
    else
        print("Failed to install " .. formatter .. "! Missing dependencies: " .. dependency)
        return false
    end
end

function M.get_path(path)
    return path .. "/node_modules/.bin/prettier"
end

return M
