#!/bin/bash

function try()
{
	bash -c "$1"

	! [[ $? -eq 0 ]] && echo "Error: $2" && rm -rf "$DST" && exit 1
}

[ -z "$1" ] && [ -e "$1" ] && echo "zip archive not specified" && exit 1

[ -d "$1" ] && echo "Warning: specified zip archive '$1' is a directory"

DST="${1%.*}"

[ "${1##*.}" != "zip" ] && echo "Warning: extension of specified archive is not '.zip'" && DST+=".unzip"

if ! [ -d "$DST" ]
then
	try "type unzip 1>/dev/null 2>&1" "python3 not installed"
	try "unzip -q -j -d $DST $1" "unzip failed unzipping $1 into $DST"
	try "chmod -R 777 $DST" "failed to set extracted folder permissions"

fi

try 'type python3 1>/dev/null 2>&1' 'python3 not installed'

try '[ -z "$(python3 -m pip 2>&1 | grep "No module named")" ]' "python3 not installed"

try 'python3 -m pip install -q imagededup' 'imgdedup failed installation'

try "./dedup.py $DST" 'failed to execute dedup.py'

try "rm -rf $DST" "Failed removing unzipped folder from output"
