
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

```bash
# Bash
packages=(
  'luci-theme-argon'
  'luci-app-argon-config'
  # ... 查看更多软件包，请点击上面的 <查看归档列表>
)
wrtPath='./zerowrt' # 请替换为 wrt 编译路径
repoUrl='https://github.com/zero-dream/zerowrt-repository/releases/latest/download'
for package in "${packages[@]}"; do
  pkgPath="$wrtPath/package/zerowrt"
  mkdir -p "$pkgPath"
  curl -L "$repoUrl/$package.tar.gz" | tar -xz -C "$pkgPath"
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

  ### 相关仓库

  [zero-dream/action-workflow](https://github.com/zero-dream/action-workflow)

  [zero-dream/zerowrt-firmware](https://github.com/zero-dream/zerowrt-firmware)

  [zero-dream/zerowrt-package](https://github.com/zero-dream/zerowrt-package)

  [zero-dream/zerowrt-immortalwrt](https://github.com/zero-dream/zerowrt-immortalwrt)

  [zero-dream/zerowrt-repository (self)](https://github.com/zero-dream/zerowrt-repository)

</div>
