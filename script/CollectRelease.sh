#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Source
source "$ZD_ScriptLibPath/createPath.sh"

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

repoCfgPath="$GITHUB_WORKSPACE/config/repository"

# --------------------------------------------------

for repoFile in "$repoCfgPath"/*; do
echo "== $repoFile =="
	# repoCfgPath="$GITHUB_WORKSPACE/config/RepoConfig.json5"
	# repoCfgJson=$(json5 "$repoCfgPath")
	# repoCfgLen=$(echo "$repoCfgJson" | jq '. | length')
done

# UpdateRelease
mirrorPath="$ZD_ReleaseUploadPath/mirror"
packagePath="$ZD_ReleaseUploadPath/package"
repoMirrorPath="$(createTempPath 'Temp_RepoMirror:dir')"
repoPackagePath="$(createTempPath 'Temp_RepoPackage:dir')"
for ((i = 0; i < repoCfgLen; i++)); do
	name=$(echo "$repoCfgJson" | jq -r ".[$i].name")
	repo=$(echo "$repoCfgJson" | jq -r ".[$i].repo")
	branch=$(echo "$repoCfgJson" | jq -r ".[$i].branch")
	# Mirror
	git clone --mirror "https://github.com/$repo.git" "$repoMirrorPath/$name.git/"
	cd "$repoMirrorPath/$name.git/"
	git bundle create "$mirrorPath/$name-$ZD_DATE.bundle" --all
	# Package
	git clone --depth=1 --single-branch --branch "$branch" "https://github.com/$repo.git" "$repoPackagePath/$name"
	tar -czpf "$packagePath/$name.tar.gz" \
		-C "$repoPackagePath" \
		"$name"
done
rm -rf "$repoMirrorPath/"
rm -rf "$repoPackagePath/"

# CreateIndexFile
# archiveListFile=""
# for ((i = 0; i < repoCfgLen; i++)); do
# 	name=$(echo "$repoCfgJson" | jq -r ".[$i].name")
# 	archiveListFile+="$name\n"
# done
# echo "$archiveListFile" >"01-ArchiveList"

# ReleaseBody
cat >"$CI_MirrorReleaseBodyPath" <<-EOF
	Mirror Release Archive
	镜像资源归档
EOF
cat >"$CI_PackageReleaseBodyPath" <<-EOF
	Package Release Archive
	软件包资源归档
EOF
