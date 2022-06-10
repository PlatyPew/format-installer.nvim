local M = {}

function M.install(path, formatter)
    M.dependencies = { "curl" }
    if vim.fn.executable(M.dependencies[1]) == 1 then
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

        local version = "3.5.1"

        local url = string.format(
            "https://github.com/mvdan/sh/releases/download/v%s/shfmt_v%s_%s_%s",
            version,
            version,
            os,
            arch
        )

        vim.fn.mkdir(path)

        vim.fn.system({ M.dependencies[1], "-fsSL", "-o", path .. "/shfmt", url })
        vim.fn.system({ "chmod", "+x", path .. "/shfmt" })
        return true
    else
        print(
            string.format(
                "Failed to install %s! Missing dependencies: %s",
                formatter,
                M.dependencies[1]
            )
        )
        return false
    end
end

function M.get_path(path)
    return path .. "/shfmt"
end

return M
