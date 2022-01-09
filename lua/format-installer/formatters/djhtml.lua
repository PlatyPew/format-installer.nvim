local M = {}

function M.install(path)
    if vim.fn.executable("virtualenv") == 1 then
        vim.fn.system({ "virtualenv", path })
        vim.fn.system({ path .. "/bin/pip3", "install", "-U", "djhtml" })
        return true
    else
        print("Failed to install djhtml! Missing dependencies: virtualenv")
        return false
    end
end

function M.get_path(path)
    return path .. "/bin/djhtml"
end

return M
