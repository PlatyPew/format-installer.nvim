local M = {}

function M.install(path, formatter)
    M.dependencies = { "curl", "tar" }
    if vim.fn.executable(M.dependencies[1]) == 1 and vim.fn.executable(M.dependencies[2]) == 1 then
        local os
        if vim.fn.has("mac") == 1 then
            os = "macos"
        else
            os = "linux"
        end

        local version = "1.4.38"

        local url = string.format(
            "https://github.com/rust-lang/rustfmt/releases/download/v%s/rustfmt_%s-x86_64_v%s.tar.gz",
            version,
            os,
            version
        )

        vim.fn.mkdir(path)

        vim.fn.system({ M.dependencies[1], "-fsSL", "-o", path .. "/rustfmt.tar.gz", url })
        vim.fn.system({ "tar", "-xzf", path .. "/rustfmt.tar.gz", "-C", path })
        vim.fn.system({
            "mv",
            path .. string.format("/rustfmt_%s-x86_64_v%s", os, version) .. "/rustfmt",
            path .. "/rustfmt",
        })
        vim.fn.system({
            "rm",
            "-rf",
            path .. "/rustfmt.tar.gz",
            path .. string.format("/rustfmt_%s-x86_64_v%s", os, version),
        })
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
    return path .. "/rustfmt"
end

return M
