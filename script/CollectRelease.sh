#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Source
source "$ZD_LibPath/createPath.sh"

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

# --------------------------------------------------

# RepositoryRelease
repoMirrorPath="$(createTempPath 'Temp_RepoMirror:dir')"
repoPackagePath="$(createTempPath 'Temp_RepoPackage:dir')"
repoCfgPath="$GITHUB_WORKSPACE/config/repository"
for cfgPath in "$repoCfgPath"/*; do
	cfgJson=$(json5 "$cfgPath")
	cfgLen=$(echo "$cfgJson" | jq '. | length')
	# UpdateRelease
	mirrorPath="$ZD_ReleaseUploadPath/mirror"
	packagePath="$ZD_ReleaseUploadPath/package"
	for ((i = 0; i < cfgLen; i++)); do
		name=$(echo "$cfgJson" | jq -r ".[$i].name")
		repo=$(echo "$cfgJson" | jq -r ".[$i].repo")
		branch=$(echo "$cfgJson" | jq -r ".[$i].branch")
		# Mirror
		git clone --mirror "https://github.com/$repo.git" "$repoMirrorPath/$name.git/"
		cd "$repoMirrorPath/$name.git/"
		git bundle create "$mirrorPath/$name-$ZD_DATE.bundle" --all
		cd "$GITHUB_WORKSPACE/"
		# Package
		git clone --depth=1 --single-branch --branch "$branch" "https://github.com/$repo.git" "$repoPackagePath/$name"
		tar -czpf "$packagePath/$name.tar.gz" \
			-C "$repoPackagePath" \
			"$name"
	done
	# CreateIndexFile
	for ((i = 0; i < cfgLen; i++)); do
		name=$(echo "$cfgJson" | jq -r ".[$i].name")
		echo "$name" >>"$mirrorPath/01-ArchiveList-$ZD_DATE"
		echo "$name" >>"$packagePath/00-IndexList"
	done
done
rm -rf "$repoMirrorPath/"
rm -rf "$repoPackagePath/"

# BodyRelease
cat >"$CI_MirrorReleaseBodyPath" <<-EOF
	Mirror Release Archive
	镜像资源归档
EOF
cat >"$CI_PackageReleaseBodyPath" <<-EOF
	Package Release Archive
	软件包资源归档
EOF
