local M = {}

function M.install(path, formatter)
    M.dependencies = { "curl", "java" }
    if vim.fn.executable(M.dependencies[1]) == 1 and vim.fn.executable(M.dependencies[2]) == 1 then
        local version = "1.13.0"

        local url = string.format(
            "https://github.com/google/google-java-format/releases/download/v%s/google-java-format-%s-all-deps.jar",
            version,
            version
        )

        vim.fn.mkdir(path)

        vim.fn.system({ M.dependencies[1], "-fsSL", "-o", path .. "/google-java-format.jar", url })

        local cmd = string.format(
            '--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED -jar "%s" "$@"',
            path .. "/google-java-format.jar"
        )

        if vim.fn.has("mac") == 1 then
            cmd = '#!/bin/bash\nexport JAVA_HOME="${JAVA_HOME:-/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home}"\nexec "${JAVA_HOME}/bin/java" '
                .. cmd
        else
            cmd = "#!/bin/bash\nexec java " .. cmd
        end

        local f = io.open(path .. "/google-java-format", "w")
        f:write(cmd)
        f:close()

        vim.fn.system({ "chmod", "+x", path .. "/google-java-format" })

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
    return path .. "/google-java-format"
end

return M
