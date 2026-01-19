
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
  # ... more packages
)
wrtPath='./zerowrt' # Please replace it with the wrt build path
repoUrl='https://github.com/zero-dream/zerowrt-repository/releases/latest/download'
for package in "${packages[@]}"; do
  curl -L "$repoUrl/$package.tar.gz" | tar -xzv -C "$wrtPath/package/"
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
  | script | Script Directory |
  | storage | Storage Directory |

</div>
