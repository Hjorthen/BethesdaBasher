#!/bin/bash 
set -euo pipefail

MODLIST=modlist.txt
STAGING_DIR="data_staging"
EXTRACT_DIR="staging_tmp"

# Cleanup existing staging folders
rm -rf "$EXTRACT_DIR" || true
rm -rf "$STAGING_DIR" || true

mkdir -p "$STAGING_DIR"

while read archive; do
	if [[ ! -f "$archive" ]]; then
		echo "$archive not a file."
		exit 1
	fi

	echo "Extracting $archive .."
	mkdir "$EXTRACT_DIR"
	bsdtar -xf "$archive" -C "$EXTRACT_DIR"

	if [[ -d "$EXTRACT_DIR/fomod" ]]; then
		echo "Fomod detected!"
		echo "Manual install required - Inspect contents in: $EXTRACT_DIR"
		echo "Figure out the necessary files, then delete everything else. The folders content will be copied to Data."
		echo "Once done, press enter to continue."
		read -r </dev/tty # Reading from file replaces stdin, we need to be specific on where our input should come from..
	fi

	if [[ -d "$EXTRACT_DIR/Data" ]]; then
		mv "$EXTRACT_DIR"/Data/* "$STAGING_DIR"
	else
		mv "$EXTRACT_DIR"/* "$STAGING_DIR"
	fi


	rm -r "$EXTRACT_DIR"
done < "${MODLIST}"
