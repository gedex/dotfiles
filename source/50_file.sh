alias l="ls -al"

# Easier navigation: .., ...
alias ..='cd ..'
alias ...='cd ../..'

# Create a new directory and enter it.
function md() {
	mkdir -p "$@" && cd "$@"
}

extract () {
	if [ $# -ne 1 ]
	then
		echo "Error: No file specified."
		return 1
	fi

	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2) tar xvjf $1   ;;
			*.tar.gz)  tar xvzf $1   ;;
			*.bz2)     bunzip2 $1    ;;
			*.rar)     unrar x $1    ;;
			*.gz)      gunzip $1     ;;
			*.tar)     tar xvf $1    ;;
			*.tbz2)    tar xvjf $1   ;;
			*.tgz)     tar xvzf $1   ;;
			*.zip)     unzip $1      ;;
			*.Z)       uncompress $1 ;;
			*.7z)      7z x $1       ;;
			*)         echo "'$1' cannot be extracted via extract" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

organize_dashcam_files() {
	if [ $# -ne 1 ]
	then
		echo "Error: No directory specified"
		return 1
	fi

	# remove trailing path
	local path=$(echo $1 | sed 's/\/$//g')

	# TODO: handle RO (read-only) dir
	if [ -d $path ]; then
		local files="$path/*.MP4"
		for file in $files; do
			if [ -f $file ]; then
				local filename=$(basename ${file})
				local date_prefix=$(echo ${filename} | cut -c 1-8)
				mkdir -p "$path/$date_prefix"
				mv $file "$path/$date_prefix/"
			fi
		done

		ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ~/iCloud
		local dirs=$(find -E $path -type d -iregex '.*/[0-9]{8}$')
		for dir in $dirs; do
			local date=$(basename $dir)
			concat_mpegs "$dir" "$HOME/Desktop/$date.mp4"
			mv "$HOME/Desktop/$date.mp4" "$HOME/iCloud/dashcam/$date.mp4"
		done
		unlink ~/iCloud
	else
		echo "Error: '$1' is not a valid directory"
	fi
}

concat_mpegs_usage() {
	echo "Usage: concat-mgpegs <dir> <final-filename>"
}

concat_mpegs() {
	if [[ "$#" -lt 2 ]]; then
		concat_mpegs_usage
		return 1
	fi

	local filelist="$1/filelist.txt"
	rm -f "${filelist}"
	touch "${filelist}"

	local files="$1/*.MP4"
	for file in $files; do
		echo "file '$(basename $file)'" >> "${filelist}"
	done

	ffmpeg -f concat -safe 0 -i "${filelist}" -c copy "$2"

	rm "${filelist}"
}

# File size.
alias fs="stat -f '%z bytes'"
alias df="df -h"

alias code="cd ~/code"
