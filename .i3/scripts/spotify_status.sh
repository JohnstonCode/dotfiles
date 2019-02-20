#!/bin/bash

spotify_status=""

update_spotify() {
	spotify_status=`~/.i3/scripts/sp current-oneline`
}

i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && update_spotify && while :
do
	read line
	update_spotify
	echo ",[{\"full_text\":\"${spotify_status}\" },${line#,\[}" || exit 1
done)
