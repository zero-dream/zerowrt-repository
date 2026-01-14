#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Source
source "$ZD_ScriptLibPath/createPath.sh"

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

repoCfgPath="$GITHUB_WORKSPACE/config/RepoConfig.json5"
repoJson=$(json5 "$repoCfgPath")
repoLen=$(echo "$repoJson" | jq '. | length')

# --------------------------------------------------

# UpdateRelease
mirrorPath="$ZD_ReleaseUploadPath/mirror"
packagePath="$ZD_ReleaseUploadPath/package"
repoMirrorPath="$(createTempPath 'Temp_RepoMirror:dir')"
repoPackagePath="$(createTempPath 'Temp_RepoPackage:dir')"
for ((i = 0; i < repoLen; i++)); do
	name=$(echo "$repoJson" | jq -r ".[$i].name")
	repo=$(echo "$repoJson" | jq -r ".[$i].repo")
	# Mirror
	git clone --mirror "https://github.com/$repo.git" "$repoMirrorPath/$name.git/"
	cd "$repoMirrorPath/$name.git/"
	git bundle create "$mirrorPath/$name-$ZD_DATE.bundle" --all
	# Package
	git clone --depth=1 "https://github.com/$repo.git" "$repoPackagePath/$name"
	tar -czpf "$packagePath/$name.tar.gz" \
		-C "$repoPackagePath" \
		"$name"
done
rm -rf "$repoMirrorPath/"
rm -rf "$repoPackagePath/"

# CreateIndexFile
archiveListFile=""
for ((i = 0; i < repoLen; i++)); do
	name=$(echo "$repoJson" | jq -r ".[$i].name")
	archiveListFile+="$name\n"
done
echo "$archiveListFile" >"01-ArchiveList"

# ReleaseBody
cat >"$CI_MirrorReleaseBodyPath" <<-EOF
	Mirror Release Archive
	镜像资源归档
EOF
cat >"$CI_PackageReleaseBodyPath" <<-EOF
	Package Release Archive
	软件包资源归档
EOF
