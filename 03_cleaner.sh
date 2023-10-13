#!/bin/bash

set -e
# The cleaner script DOES NOT receive any paramaters and it must do the following: 
# 1. Compress each individual .log file into a .tar.gz file in the ~/apps directory
#    with the name of $number-$app-$hash.tar.gz where number and app are the same as 
#    the original file, and hash is a unique 7-character string dynamically generated 
#    for each new compressed file.
# 2. Move each compressed file to a subdirectory matching the app name defined in the filename.
#    Example: ~/apps/order1-acd34rf.tar.gz would be moved to ~/apps/order/order1-acd34rf.tar.gz
# 3. Delete the .log file ONLY after succesfully compressing and moving the compressed file to the
#    corresponding subdirectory


cd ~/apps

# stderr is sent to /dev/null
for i in $(ls *.log 2> /dev/null); do 
    file=$(cut -d "." -f 1 <<< $i) #payment1.log --> payment1
    # app=$(echo $file | grep -o '[0-9]\+')
    app=$(echo $file | sed 's/[0-9]*$//') #payment1 --> payment 
    hash=$(md5sum <<< $RANDOM | head -c 7)
    mkdir -p ./$app 
    tar_path="./$app/${file}-${hash}.tar.gz"
    tar -czf ${tar_path} $i 
    echo "succesfully compressed $i into ${tar_path}"
    
    rm -rf $i 
    echo "succesfully deleted $i"
    
done    
    
   