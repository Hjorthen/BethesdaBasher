#!/bin/bash
set -euo pipefail

rm -f modlist.txt
for file in ./modfiles/*; do
	echo "$file" >> modlist.txt
done
