#!/bin/bash
# https://unix.stackexchange.com/questions/204335/how-can-i-copy-a-file-in-a-bash-script-and-rename-it-while-copying-and-place-it

src="$1"

for file in $(find $src -type f -name "*.java"); 
do
	dir=$(dirname -- "$file")
  	case $dir in
    	(*[!/]*) dir=$dir/ # handle / and // specially
 	esac
  	base=$(basename -- "$file")
  	name=${base%.*}
  	name=${name:-$base} # don't consider .bashrc the extension in /foo/.bashrc
  	ext=${base#"$name"}
  	new_file=$dir${name}_copy$ext
	iconv -f ISO-8859-1 -t UTF-8 $file -o $new_file
	cp "$new_file" "$file"
	rm "$new_file"
done;
