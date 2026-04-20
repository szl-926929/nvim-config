local options = {
    -- 使用国内镜像 registry（如果有）
    -- 注意：目前官方没有国内 registry 镜像，需要自建或使用代理
    registries = {
        -- 默认官方 registry，会通过代理访问
        "github:mason-org/mason-registry",
        -- 可以添加自建 registry
        -- "github:your-username/mason-registry-mirror",
    },

    -- GitHub 镜像配置（通过 git 配置）
    git = {
        -- 使用 ghproxy 等 GitHub 镜像服务
        clone_url_template = "https://ghproxy.com/https://github.com/%s.git",
    },

    -- pip 国内镜像（针对 Python 工具）
    pip = {
        upgrade_pip = true,
        install_args = {
            "--index-url",
            "https://pypi.tuna.tsinghua.edu.cn/simple",
            "--trusted-host",
            "pypi.tuna.tsinghua.edu.cn",
            "--no-cache-dir",
        },
    },

    -- npm 国内镜像（针对 JS/TS 工具）
    npm = {
        install_args = {
            "--registry",
            "https://registry.npmmirror.com",
            "--no-audit",
            "--no-fund",
        },
    },
}

return options
