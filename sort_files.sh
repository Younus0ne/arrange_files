#!/bin/bash

read -rp "Enter the files u want to sort: " file_type

cd ~ 
all_folders=($(ls))
#mkdir -p  sorted_folder/$file_type


for i in ${all_folders[@]} ; do


#if [ $i == "Pictures" ]; then    ----first version
#echo "passed the og folder"
#continue
#fi

echo "--- searching in the folder $i ---"

cd $i
in_fold=($(ls -p | grep -v /))
for j in ${in_fold[@]}; do

if [[ $j == *.jpg ]]; then
echo "a file found"
echo "------- the file is $j ------------"
mv $j ~/Pictures/images
echo "file moved"
fi
done
cd ~

done













