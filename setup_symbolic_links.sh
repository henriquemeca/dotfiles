#!/bin/bash

create_link() {
	source_dir=$1
	target_dir=$2

	if [[ -d $target_dir ]] || [[ -f $target_dir ]]; then
		echo "Symbolic link already exists for $source_dir in $target_dir"
	else
		echo "Creating link from $source_dir to $target_dir"
		ln -s $source_dir $target_dir
		echo "Link created"
	fi
}

### Add symlinks to all "./config" subfolders
for dir in $(find "config" -maxdepth 1 -mindepth 1 -type d); do
	source_dir="$(pwd)/$dir"
	target_dir="$HOME/.$dir"

	create_link $source_dir $target_dir

done


### Add .files
files=("vimrc" "tmux" "tmux.conf" "powerlevel10k" "zshrc")

for file in "${files[@]}"; do
	source="$(pwd)/$file"
	target="$HOME/.$file"

	create_link $source $target
done

#./set_lazy_vim.sh
