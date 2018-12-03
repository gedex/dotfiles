function browser() {
	case $OSTYPE in
		linux*)
			if [ -x "$(which google-chrome 2>/dev/null)" ]
			then
				AVAILABE_BROWSER="google-chrome"
			elif [ -x "$(which firefox 2>/dev/null)" ]
			then
				AVAILABE_BROWSER="firefox"
			else
				printf '%s\n' 'No google-chrome or firefox'
				exit 1
			fi

			if [ -t 0 ]
			then
				if [ -n "$1" ]
				then
					$AVAILABE_BROWSER "$1"
				fi
			else
				f="/tmp/browser.$RANDOM.html"
				cat /dev/stdin > $f
				$AVAILABE_BROWSER "$f"
			fi
			;;
		darwin*)
			if [ -t 0 ]; then
				if [ -n "$1" ]; then
					open $1
				else
					reference browser
				fi

			else
				f="/tmp/browser.$RANDOM.html"
				cat /dev/stdin > $f
				open $f
			fi
			;;
	esac
}
