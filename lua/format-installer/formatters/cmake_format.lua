local M = {}

function M.install(path)
    if vim.fn.executable("virtualenv") == 1 then
        vim.fn.system({ "virtualenv", path })
        vim.fn.system({ path .. "/bin/pip3", "install", "-U", "cmakelang" })
        return true
    else
        print("Failed to install cmake_format! Missing dependencies: virtualenv")
        return false
    end
end

function M.get_path(path)
    return path .. "/bin/cmake-format"
end

return M
