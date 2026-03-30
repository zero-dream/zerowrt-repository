#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Source
source "$ZD_LibPath/config.sh"

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

# --------------------------------------------------

# CreatePath
archiveListPath="$CI_TempPath/ArchiveList" && mkdir -p "$archiveListPath"
cp -a "$CI_StoragePath/github/ArchiveList.md" "$archiveListPath/ArchiveList.md"

# GenerateData
repositorys=()
archiveList="\n"
archiveList+="UpdateTime: $ZD_Date"
archiveList+="\n"
archiveList+="|Name|Link|\n"
archiveList+="|----|----|\n"
repoCfgPath="$GITHUB_WORKSPACE/config/repository"
for cfgPath in "$repoCfgPath"/*; do
	cfgJson=$(json5 "$cfgPath")
	cfgLen=$(echo "$cfgJson" | jq '. | length')
	for ((i = 0; i < cfgLen; i++)); do
		name=$(echo "$cfgJson" | jq -r ".[$i].name")
		repo=$(echo "$cfgJson" | jq -r ".[$i].repo")
		repositorys+=("$name")
		archiveList+="| $name | [$repo](https://github.com/$repo) |\n"
	done
done

# UpdateArchiveList
updateRepoCfg=$(readConfig 'update-repo')
sha256Expected=$(echo "$updateRepoCfg" | jq -r '.["repo-config"].sha256 // ""')
sha256Computed=$(printf "%s\n" "${repositorys[@]}" | sort | sha256sum | awk '{print $1}')
if [[ "$sha256Expected" != "$sha256Computed" ]]; then
	# WriteConfig
	updateRepoCfg=$(echo "${updateRepoCfg:-{}}" |
		jq --arg sha256 "$sha256Computed" '
			.["repo-config"] = (.["repo-config"] // {}) |
			.["repo-config"].sha256 = $sha256
    ')
	writeConfig 'update-repo' "$updateRepoCfg"
	# UpdateFile
	awk -i inplace -v value="$archiveList" '
		/<!-- Zero-ArchiveList-Start -->/ {
			print
			print value
			skip = 1
			next
		}
		/<!-- Zero-ArchiveList-End -->/ {
			skip = 0
		}
		!skip { print }
	' "$archiveListPath/ArchiveList.md"
fi
