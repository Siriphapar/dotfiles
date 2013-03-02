#!/bin/bash
FILES=".ctags .gitconfig .gitignore .npmrc .profile .tfrc .vimrc"
for file in ${FILES}
do
    root_file="/Users/edmond/${file}"
    local_file="`pwd`/${file}"

    if [ -f ${root_file} ]
    then
        if [ -h "${root_file}" ]
        then
            rm "${root_file}"
        else
            mv ${local_file} ${root_file}.bak
        fi
    fi

    echo "ln -s $local_file $root_file"
    ln -s $local_file $root_file
done