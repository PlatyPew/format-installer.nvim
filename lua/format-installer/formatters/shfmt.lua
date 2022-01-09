local M = {}

function M.install(path, formatter)
    local dependency = "curl"
    if vim.fn.executable(dependency) == 1 then
        local url = "https://github.com/mvdan/sh/releases/download/v3.4.2/shfmt_v3.4.2_"

        local os
        if vim.fn.has("mac") == 1 then
            os = "darwin"
        else
            os = "linux"
        end

        local arch
        if vim.fn.trim(vim.fn.system({ "uname", "-m" })) == "arm64" then
            arch = "arm64"
        else
            arch = "amd64"
        end

        url = url .. os .. "_" .. arch

        vim.fn.mkdir(path)

        vim.fn.system({ dependency, "-fsSL", "-o", path .. "/shfmt", url })
        vim.fn.system({ "chmod", "+x", path .. "/shfmt" })
        return true
    else
        print("Failed to install " .. formatter .. "! Missing dependencies: " .. dependency)
        return false
    end
end

function M.get_path(path)
    return path .. "/shfmt"
end

return M
