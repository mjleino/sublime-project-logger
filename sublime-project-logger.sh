#!/bin/bash

# config
LOGS_DIR=~/.spl-logs
DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

# setup, helpers
mkdir -p $LOGS_DIR
today=$(date "+%Y%m%d")
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
locked_screen() { # http://stackoverflow.com/a/11511419
	python -c 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); sys.exit(not (d and d.get("CGSSessionScreenIsLocked", 0) == 0 and d.get("kCGSSessionOnConsoleKey", 0) == 1))'
}

# bail if the screen is locked
locked_screen || exit 1 
 
currentProject=$(osascript -l JavaScript $dir/TopmostSublimeProject.scpt 2>&1)
currentProject=${currentProject##* — }
[ -z "$currentProject" ] && exit 2 # bail if sublime text isn't open

output="$LOGS_DIR/$today".tmp
found=false
if [ -f "$LOGS_DIR/$today" ]; then
	head -n 1 "$LOGS_DIR/$today" > $output
	while IFS=':' read -r project minutes; do
		if [ "$project" == "$currentProject" ]; then
			((minutes++))
			found=true
		fi
		echo $project: $minutes >> $output
	done < <(sed '1d;$d' "$LOGS_DIR/$today")
else
	echo \# LOG OPENED $(date "$DATE_FORMAT") > $output
fi
[ "$found" == false ] && echo $currentProject: 1 >> $output
echo \# LOG CLOSED $(date "$DATE_FORMAT") >> $output
mv $output "$LOGS_DIR/$today"