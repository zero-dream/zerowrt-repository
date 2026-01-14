#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Param
updatePath=$1

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

repoCfgPath="$GITHUB_WORKSPACE/config/RepoConfig.json5"
repoJson=$(json5 "$repoCfgPath")
repoLen=$(echo "$repoJson" | jq '. | length')

# --------------------------------------------------

# UpdateArchiveList
repoConfigHashPath="$updatePath/config/RepoConfig.sha256"
repoConfigPath="$updatePath/config/RepoConfig.json5"
sha256Expected=$(cat "$repoConfigHashPath")
sha256Computed=$(sha256sum "$repoConfigPath" | awk '{print $1}')
if [[ "$sha256Expected" != "$sha256Computed" ]]; then
	printf "$sha256Computed" >"$repoConfigHashPath"
	archiveList="\n"
	archiveList+="UpdateTime: $ZD_DATE"
	archiveList+="\n"
	archiveList+="|Name|Link|\n"
	archiveList+="|----|----|\n"
	for ((i = 0; i < repoLen; i++)); do
		name=$(echo "$repoJson" | jq -r ".[$i].name")
		repo=$(echo "$repoJson" | jq -r ".[$i].repo")
		archiveList+="| $name | [$repo](https://github.com/$repo) |\n"
	done
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
	' "$updatePath/storage/github/ArchiveList.md"
fi
