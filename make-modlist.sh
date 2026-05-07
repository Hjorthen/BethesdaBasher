#!/bin/bash
set -euo pipefail
TMP_DIR=".tmp"
FILE_MODLIST="modlist.txt"
FILE_GEN_MODLIST="$TMP_DIR/modlist_generated.txt"
FILE_NEW_MODENTRIES="$TMP_DIR/modlist_new.txt"

temp_delete () {
	if [[ -d "$TMP_DIR" ]] ; then
		rm -r "$TMP_DIR"
	fi
}

temp_delete
mkdir "$TMP_DIR"

for file in ./modfiles/*; do
	if file "$file" | grep -q "archive data"; then
		echo "$file" >> "$FILE_GEN_MODLIST"
	else
		echo "Skipping file $file. Was not detected as archive data."
	fi
done

if [[ -f "$FILE_MODLIST" ]]; then
	# A modlist already exists.. We have to merge.
	echo "Existing modlist found. Adding new entries, keeping previous deploy-order."
	comm -13 <(sort "$FILE_MODLIST") <(sort "$FILE_GEN_MODLIST") > "$FILE_NEW_MODENTRIES"
	
	# Check if we have any mods in the old modlist that wasn't generated in the new
	# Happens if the user has deleted a modfile and not from the modlist
	DELETED_MODS="$(comm -23 <(sort "$FILE_MODLIST") <(sort "$FILE_GEN_MODLIST"))"
	if  [[ -n $DELETED_MODS ]] ; then
		echo "!! Mod(s) detected on the modlist which has had their modfile(s) deleted."
		echo "!! Remember the tool cannot delete files from your Data/ folder and hence cannot delete mods."
		echo "!! You may proceed if you understand that the mod might still be installed in your game."
		echo "!! You can manually delete the mod's files from Data/ or revalidate the game's cache."
		echo "The detected mods are:"
		echo "$DELETED_MODS"
	fi
else 
	# No modlist, we can just move the file
	mv "$FILE_GEN_MODLIST" "$FILE_NEW_MODENTRIES"
fi

# Determine the amount of mods to be added. 
# Use 'cat' to avoid wc including the filename in the output.
NEW_MODENTRY_COUNT=$(cat "$FILE_NEW_MODENTRIES" | wc -l)
echo "Found $NEW_MODENTRY_COUNT new mods to add."
echo "New mods added:"
echo "$(cat $FILE_NEW_MODENTRIES)"
cat "$FILE_NEW_MODENTRIES" >> "$FILE_MODLIST"

temp_delete
