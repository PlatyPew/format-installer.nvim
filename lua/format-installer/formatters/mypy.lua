local M = {}

function M.install(path, formatter)
    local dependency = "virtualenv"
    if vim.fn.executable(dependency) == 1 then
        vim.fn.system({ dependency, path })
        vim.fn.system({ path .. "/bin/pip3", "install", "-U", "mypy" })
        return true
    else
        print("Failed to install " .. formatter .. "! Missing dependencies: " .. dependency)
        return false
    end
end

function M.get_path(path)
    return path .. "/bin/mypy"
end

return M
