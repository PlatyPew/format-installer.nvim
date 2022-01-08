local M = {}

function M.install(path)
    if vim.fn.executable("curl") == 1 then
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

        vim.fn.system({ "curl", "-fsSL", "-o", path .. "/shfmt", url })
        vim.fn.system({ "chmod", "+x", path .. "/shfmt" })
        return true
    else
        print("Failed to install shfmt! Missing dependencies: curl")
        return false
    end
end

function M.get_path(path)
    return path .. "/shfmt"
end

return M
