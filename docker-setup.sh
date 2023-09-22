#!/bin/bash

mkdir -p output

DST="$1"

DST="$(echo "$1" | sed -E 's<^(.*/)?output/<<')"

if [ -f "./output/$DST" ]
then
	TARGET_ARCHIVE="$DST"

elif [ -f "$DST" ]
then
	TARGET_ARCHIVE="$(echo "$DST" | sed -E 's@.*/@@g')"
	! [ -f "./output/$TARGET_ARCHIVE" ] && cp -r "$DST" "./output/$TARGET_ARCHIVE"

else
	[ -n "$DST" ] && echo "Warning: Couldn't find '$DST'"
	read -p "Enter name with extension of target archive (exit with Ctrl+c): " DST
	TARGET_ARCHIVE="$(echo "$DST" | sed -E 's@.*/@@g')"
	[ -f "$DST" ] && ! [ -f "./output/${TARGET_ARCHIVE}" ] && cp -r "$DST" "./output/$TARGET_ARCHIVE"
	if ! [ -f "./output/$TARGET_ARCHIVE" ]
	then
		echo "Warning: '$DST' not found"
		TARGET_PATH=""
		while ! [ -f "$TARGET_PATH" ]
		do 
			read -p "Enter full path to target archive (exit with Ctrl+c): " TARGET_PATH

			! [ -f "$TARGET_PATH" ] && echo "Error: can't find archive at '$TARGET_PATH'."

		done
		cp -r "$TARGET_PATH" "./output/$TARGET_ARCHIVE"

	fi

fi

cat ./Dockerfile | sed -E 's<CMD.*$<CMD [ "'"/output/$TARGET_ARCHIVE"'" ]<' > ./Dockerfile.tmp

! [[ $? -eq 0 ]] && echo "Error editing Dockerfile. Exiting" && rm -f ./Dockerfile.tmp && exit 1

mv ./Dockerfile.tmp ./Dockerfile

docker-compose down

docker rmi dedup-python3 2>/dev/null

docker-compose up
