local M = {}

function M.install(path, formatter)
    M.dependencies = { "curl", "tar" }
    if vim.fn.executable(M.dependencies[1]) == 1 and vim.fn.executable(M.dependencies[2]) == 1 then
        local os
        if vim.fn.has("mac") == 1 then
            os = "OSX"
        else
            os = "Linux"
        end

        local arch
        if vim.fn.trim(vim.fn.system({ "uname", "-m" })) == "arm64" then
            arch = "arm64"
        else
            arch = "x86_64"
        end

        local version = "1.3.0"

        local url = string.format(
            "https://github.com/klauspost/asmfmt/releases/download/v%s/asmfmt-%s_%s_%s.tar.gz",
            version,
            os,
            arch,
            version
        )

        vim.fn.mkdir(path)

        vim.fn.system({ M.dependencies[1], "-fsSL", "-o", path .. "/asmfmt.tar.gz", url })
        vim.fn.system({ "tar", "-xzf", path .. "/asmfmt.tar.gz", "-C", path })
        vim.fn.system({ "rm", path .. "/asmfmt.tar.gz" })
        return true
    else
        print(
            string.format(
                "Failed to install %s! Missing dependencies: %s, %s",
                formatter,
                M.dependencies[1],
                M.dependencies[2]
            )
        )
        return false
    end
end

function M.get_path(path)
    return path .. "/asmfmt"
end

return M
