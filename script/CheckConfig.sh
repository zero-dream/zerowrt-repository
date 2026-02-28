#!/bin/bash
# Copyright (C) 2000 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

cd "$GITHUB_WORKSPACE/"

# --------------------------------------------------

# CheckConfig
isExit=0
declare -A repos
repoCfgPath="$GITHUB_WORKSPACE/config/repository"
for cfgPath in "$repoCfgPath"/*; do
	cfgJson=$(json5 "$cfgPath")
	cfgLen=$(echo "$cfgJson" | jq '. | length')
	for ((i = 0; i < cfgLen; i++)); do
		name=$(echo "$cfgJson" | jq -r ".[$i].name")
		if [[ -n "${repos[$name]}" ]]; then
			echo "Error: [$name]: duplicate package exist"
			isExit=1
		fi
		repos["$name"]=1
	done
done
[[ $isExit -eq 1 ]] && exit 1

# --------------------------------------------------

exit 0
