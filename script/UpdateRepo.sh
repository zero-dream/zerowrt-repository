#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Param
updatePath=$1

# Source
source "$ZD_ScriptLibPath/config.sh"

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

repoCfgPath="$GITHUB_WORKSPACE/config/RepoConfig.json5"
repoJson=$(json5 "$repoCfgPath")
repoLen=$(echo "$repoJson" | jq '. | length')

# --------------------------------------------------

# UpdateArchiveList
updateRepoCfg=$(readConfig 'update-repo')
repoConfigPath="$updatePath/config/RepoConfig.json5"
sha256Expected=$(echo "$updateRepoCfg" | jq -r '.repo-config.sha256 // ""')
sha256Computed=$(sha256sum "$repoConfigPath" | awk '{print $1}')
if [[ "$sha256Expected" != "$sha256Computed" ]]; then
	# WriteConfig
	updateRepoCfg=$(echo "$sha256Expected" |
		jq --arg sha256 "$sha256Computed" 'if length > 0 then . else {} end | .repo-config.sha256 = $sha256')
	writeConfig 'update-repo' "$updateRepoCfg"
	# UpdateFile
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
