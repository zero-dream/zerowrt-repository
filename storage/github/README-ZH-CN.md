
[en-us-link]: /README.md
[zh-cn-link]: /storage/github/README-ZH-CN.md
[archive-list]: /storage/github/ArchiveList.md
[latest-package]: https://github.com/zero-dream/zerowrt-repository/releases/latest

<div align="center">

  ### ZeroWrt Repository

  [English][en-us-link] | **简体中文**

  定期归档 OpenWrt 软件包

  ### 注意事项

  本仓库仅用于归档

  软件包的版权与许可证信息

  请查看各自原始仓库

  \--------------------------------------------------

  ### 快速访问

  [查看归档列表][archive-list]

  [查看最新软件包][latest-package]

  \--------------------------------------------------

  ### 使用方法

  <div align="left">

    ```shell
    # Bash
    packages=(
      'luci-theme-argon'
      'luci-app-argon-config'
      # ... more packages
    )
    wrtPath='./zerowrt' # 请替换为 wrt 编译路径
    repoUrl='https://github.com/zero-dream/zerowrt-repository/releases/latest/download'
    for package in "${packages[@]}"; do
      curl -L "$repoUrl/$package.tar.gz" | tar -xzv -C "$wrtPath/package/"
    done
    ```

  </div>

  \--------------------------------------------------

  ### 目录简要说明

  | 目录 | 作用 |
  | :---: | :---: |
  | zerodream | 私有目录，禁止修改 |
  | hook | Workflow 专用目录 |
  | application | 应用目录 |
  | config | 配置目录 |
  | script | 脚本目录 |
  | storage | 储存目录 |

</div>
