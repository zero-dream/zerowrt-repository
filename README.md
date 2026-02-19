
[en-us-link]: /README.md
[zh-cn-link]: /storage/github/README-ZH-CN.md
[archive-list]: /storage/github/ArchiveList.md
[latest-package]: https://github.com/zero-dream/zerowrt-repository/releases/latest

<div align="center">

  ### ZeroWrt Repository

  **English** | [简体中文][zh-cn-link]

  Scheduled archiving of OpenWrt packages

  ### Precautions

  This repository is for archival purposes only

  For the copyright and license information of the software packages

  Please check each original repository

  \--------------------------------------------------

  ### Quick Access

  [ViewArchiveList][archive-list]

  [ViewLatestPackage][latest-package]

  \--------------------------------------------------

  ### Usage

  <div align="left">

```bash
# Bash
packages=(
  'luci-theme-argon'
  'luci-app-argon-config'
  # ... To see more packages, please click on <ViewArchiveList> above
)
wrtPath='./zerowrt' # Please replace it with the wrt build path
repoUrl='https://github.com/zero-dream/zerowrt-repository/releases/latest/download'
for package in "${packages[@]}"; do
  pkgPath="$wrtPath/package/zerowrt"
  mkdir -p "$pkgPath"
  curl -L "$repoUrl/$package.tar.gz" | tar -xz -C "$pkgPath"
done
```

  </div>

  \--------------------------------------------------

  ### Directory Description

  | Directory | Usage |
  | :---: | :---: |
  | zerodream | Private Directory |
  | hook | Workflow SpecialUse Directory |
  | application | Application Directory |
  | config | Configuration Directory |
  | library | Library Directory |
  | script | Script Directory |
  | storage | Storage Directory |

  ### Related Repository

  [zero-dream/github-action](https://github.com/zero-dream/github-action)

  [zero-dream/zerowrt-firmware](https://github.com/zero-dream/zerowrt-firmware)

  [zero-dream/zerowrt-package](https://github.com/zero-dream/zerowrt-package)

  [zero-dream/zerowrt-immortalwrt](https://github.com/zero-dream/zerowrt-immortalwrt)

  [zero-dream/zerowrt-repository (self)](https://github.com/zero-dream/zerowrt-repository)

</div>
