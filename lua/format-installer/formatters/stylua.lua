local M = {}

function M.install(path, formatter)
    M.dependencies = { "curl", "unzip" }
    if vim.fn.executable(M.dependencies[1]) == 1 and vim.fn.executable(M.dependencies[2]) == 1 then
        local os
        if vim.fn.has("mac") == 1 then
            os = "macos"
        else
            os = "linux"
        end

        local version = "0.11.3"

        local url = string.format(
            "https://github.com/JohnnyMorganz/StyLua/releases/download/v0.11.3/stylua-%s-%s.zip",
            version,
            os
        )

        vim.fn.mkdir(path)

        vim.fn.system({ M.dependencies[1], "-fsSL", "-o", path .. "/stylua.zip", url })
        vim.fn.system({ M.dependencies[2], path .. "/stylua.zip", "-d", path })
        vim.fn.system({ "chmod", "+x", path .. "/stylua" })
        vim.fn.system({ "rm", path .. "/stylua.zip" })
        return true
    else
        print(
            "Failed to install "
                .. formatter
                .. "! Missing dependencies: "
                .. M.dependencies[1]
                .. ", "
                .. M.dependencies[2]
        )
        return false
    end
end

function M.get_path(path)
    return path .. "/stylua"
end

return M
