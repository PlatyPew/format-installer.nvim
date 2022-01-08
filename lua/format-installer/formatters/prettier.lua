local M = {}

function M.install(path)
    if vim.fn.executable("npm") == 1 then
        vim.fn.system({ "npm", "install", "--prefix", path, "prettier" })
        return true
    else
        print("Failed to install prettier! Missing dependencies: npm")
        return false
    end
end

function M.get_path(path)
    return path .. "/node_modules/.bin/prettier"
end

return M
