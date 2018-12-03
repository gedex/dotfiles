#!/usr/bin/env bash

wcez_usage() {
	if [[ ! -z "$1" ]]; then
		echo -e "$1\n"
	fi

	echo "Usage: wcez <extension-slug> <dst> [-b branch] [-t tag]"
}

wcez() {
	if [[ "$#" -lt 2 ]]; then
		wcez_usage
		return 1
	fi

	local slug dst tag tmp
	local branch="master"
	local current=`pwd`

	while [ "$1" ]; do
		if [ "$1" == "-t" ]; then
			shift
			tag="$1"
			shift
		elif [ "$1" == "-b" ]; then
			shift
			branch="$1"
			shift
		else
			# extension-slug followed by dst (of zip file)
			slug="$1"
			shift
			dst="$1"
			shift
		fi
	done

	if [[ -z "$slug" ]]; then
		wcez_usage "Error: missing extension-slug"
		return 1
	fi

	if [[ -z "$dst" ]]; then
		wcez_usage "Error: missing dst"
		return 1
	fi

	tmp=`mktemp -d`
	if [ $? -ne 0 ]; then
		echo "Unable to create temporary directory for git-clone"
		return 1
	fi

	git clone "git@github.com:woocommerce/$slug" "$tmp"
	if [ $? -ne 0 ]; then
		echo "Failed to clone git@github.com:woocommerce/$slug"
		rm -rf "$tmp"
		return 1
	fi

	git ls-remote --heads "git@github.com:woocommerce/$slug" "$branch" | grep "$branch" >/dev/null
	if [ "$?" == "1" ]; then
		echo "Branch $branch does not exists"
		rm -rf "$tmp"
		return 1
	fi

	cd "$tmp"
	git archive "origin/$branch" --prefix="$slug/" -o "$dst"
	if [ $? -ne 0 ]; then
		echo "Failed to create the zip with git-archive"
		cd "$current"
		rm -rf "$tmp"
		return 1
	fi

	echo "Archive created at $dst."

	cd "$current"
	rm -rf "$tmp"

	return 0
}

wcer_usage() {
	if [[ ! -z "$1" ]]; then
		echo -e "$1\n"
	fi

	echo "Usage: wcer <extension-slug> [-l] [-b]"
	echo ""
	echo " -l only show latest release"
	echo " -b show body"
}

wcer() {
	if [[ "$#" -lt 1 ]]; then
		wcer_usage
		return 1
	fi

	local slug only_latest_release show_body

	while [ "$1" ]; do
		if [ "$1" == "-l" ]; then
			only_latest_release="yes"
			shift
		elif [ "$1" == "-b" ]; then
			show_body="yes"
			shift
		else
			slug="$1"
			shift
		fi
	done

	if [[ -z "$slug" ]]; then
		wcer_usage "Error: missing extension-slug"
		return 1
	fi

	local jq_in='.[] | .tag_name'
	local api_url="https://api.github.com/repos/woocommerce/${slug}/releases"
	if [[ "$only_latest_release" == "yes" ]]; then
		api_url="https://api.github.com/repos/woocommerce/${slug}/releases/latest"
		jq_in='.tag_name'
	fi

	if [[ "$show_body" == "yes" ]]; then
		jq_in="${jq_in}, .body"
	fi

	curl -s -H "Authorization: token ${GITHUB_TOKEN}" "$api_url" | jq "$jq_in"
}
