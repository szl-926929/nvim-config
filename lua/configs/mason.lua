local options = {
    -- 使用国内镜像 registry（如果有）
    -- 注意：目前官方没有国内 registry 镜像，需要自建或使用代理
    registries = {
        -- 默认官方 registry，会通过代理访问
        "github:mason-org/mason-registry",
        -- 可以添加自建 registry
        -- "github:your-username/mason-registry-mirror",
    },

    -- GitHub 镜像配置
    git = {
        -- 仅影响 Mason 用 git 拉取的包（registry 等）
        clone_url_template = "https://ghproxy.com/https://github.com/%s.git",
    },
    -- Release 二进制下载（marksman、ripgrep 等走 GitHub releases，不经上面的 git 模板）
    -- 国内直连 github.com 常超时/失败；与 clone 一样走 ghproxy 前缀。
    -- 若仍失败：换可用镜像域名、或开代理后把本段改回默认 URL 测试。
    github = {
        download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
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
