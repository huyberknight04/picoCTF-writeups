#!/bin/bash

category_dir="$1"
challenge_dir="$2"

if [ -z "$category_dir" ] || [ -z "$challenge_dir" ]; then
	echo "Usage: $0 <category_dir> <challenge_dir>"
	exit 1
fi

path="$category_dir/$challenge_dir"
file="$path/$challenge_dir.md"

if [ ! -d "$category_dir" ]; then
	echo "Directory $category_dir/ not found."
	exit 1
elif [ -d "$path" ]; then
	echo "Directory $path already exists."
	exit 1
else
	mkdir -p "$path/images/"
	cp template.md "$file"
	echo "Created."
fi

read -p "Challenge name: " challenge_name
read -p "Difficulty: " difficulty
read -p "Category: " category
read -p "Platform: " platform
read -p "Tag: " tag
read -p "Author: " author
date=$(date '+%d/%m/%Y')

sed -i \
	-e "s|# :briefcase: Challenge name|# :briefcase: $challenge_name|" \
	-e "s|- \*\*Difficulty\*\*:|- **Difficulty**: \`$difficulty\`|" \
	-e "s|- \*\*Category\*\*:|- **Category**: \`$category\`|" \
	-e "s|- \*\*Platform\*\*:|- **Platform**: \`$platform\`|" \
	-e "s|- \*\*Tag\*\*:|- **Tag**: \`$tag\`|" \
	-e "s|- \*\*Author\*\*:|- **Author**: \`$author\`|" \
	-e "s|- \*\*Date\*\*:|- **Date**: \`$date\`|" \
	"$file"

vim "$file"
