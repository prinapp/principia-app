#!/bin/bash
cd ..
cd Data
declare -a files=() #declare empty array to hold filenames

#http://cognitiveatrophy.blogspot.com/2006/07/simple-shell-script-to-remove-spaces.html
for file in *\ *;
do
mv "$file" "${file// /_}"
done
#loop through the list of files and add them into the file name array.
for entry in *
do
	echo "$entry"
	files=("${files[@]}" $entry)
done
#if the file array is greater than 1 then process if not skip
	echo ${files[@]}
	echo ${files[0]}
	echo ${files[1]}

	cp ${files[1]} ${files[0]}
	rm ${files[1]}
	for entry in *
	do
		mv $entry menu.csv
	done

