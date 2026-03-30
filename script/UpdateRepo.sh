#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Param
updatePath=$1

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

# --------------------------------------------------

# ArchiveList
cp -a "$CI_TempPath/ArchiveList/ArchiveList.md" "$updatePath/storage/github/ArchiveList.md"
