local M = {}

function M.install(path)
    if vim.fn.executable("curl") == 1 and vim.fn.executable("unzip") == 1 then
        local os
        if vim.fn.has("mac") == 1 then
            os = "macos"
        else
            os = "linux"
        end

        local url = "https://github.com/JohnnyMorganz/StyLua/releases/download/v0.11.3/stylua-0.11.3-"
            .. os
            .. ".zip"

        vim.fn.mkdir(path)

        vim.fn.system({ "curl", "-fsSL", "-o", path .. "/stylua.zip", url })
        vim.fn.system({ "unzip", path .. "/stylua.zip", "-d", path })
        vim.fn.system({ "chmod", "+x", path .. "/stylua" })
        vim.fn.system({ "rm", path .. "/stylua.zip" })
        return true
    else
        print("Failed to install stylua! Missing dependencies: curl, unzip")
        return false
    end
end

function M.get_path(path)
    return path .. "/stylua"
end

return M