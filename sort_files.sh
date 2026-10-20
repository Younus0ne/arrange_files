#!/bin/bash

pics=("jpg" "png" "jpeg" "svg" "webp" "gif")
vids=("mp4" "mkv" "mov")
text=("txt" "csv" "json")
codes=("py" "c" "cpp" "html" "js" "css" "java" "sh")
audio=("mp3" "wav" "m4a")
declare -A dic=([images]="${pics[@]}" [videos]="${vids[@]}" [texts]="${text[@]}" [program]="${codes[@]}" [audio]="${audio[@]}")
keys=("${!dic[@]}")

#function to give extensions -----
extentions () {
for i in "${!dic[@]}"; do 
	if [[ "$i" == "$user_selection" ]];then
		reverted=(${dic[$i]})
		read -ra extends <<< "${reverted[@]}"
		for j in "${extends[@]}";do
			echo "$j"
		done
		return 0
	fi
done
} 


echo "Your options are   ${!dic[@]}"
echo "Select the option based on the index. (starts from the 0) "

read -rp "Enter the files u want to sort: " user
user_selection="${keys[$user]}"
echo "you have selected $user_selection "

#---greeting the extensions---
mapfile -t ans < <(extentions)

cd ~ 
all_folders=($(ls))
mkdir -p  sorted_folder/$user_selection

pattern=$(IFS="|"; echo "${ans[*]}")
for i in ${all_folders[@]} ; do
	
	if [[ "$i" == "sorted_folder" ]];then
		echo "OG folder skipped"
		continue
	fi
	echo "--- searching in the folder $i ---"
	cd $i
	#----------------
	sub_folders=($(ls -p | grep /))	
	#------------------
	in_fold=($(ls -p | grep -v /))
		for j in ${in_fold[@]}; do
			if [[ "$j" =~ \.($pattern)$ ]]; then
				echo "a file found"
				echo "------- the file is $j ------------"
				mv $j ~/sorted_folder/$user_selection
				echo "file moved"
			fi
		done
		
	#--------------------------
	for k in ${sub_folders[@]}; do
		cd $k
		echo "--- searching in the sub folder $k ---"
		in_sub_fold=($(ls -p | grep -v /))
		for l in ${in_sub_fold[@]}; do                                 
			if [[ "$l" =~ \.($pattern)$ ]]; then
				echo "a file found"
				echo "------- the file is $l ------------"
				mv $l ~/sorted_folder/$user_selection
				echo "file moved"
			fi
		done
		cd ..
	done
	#-------------------------	
cd ~
done
echo "~~~~~ All selected files moved successfully ~~~~~"









