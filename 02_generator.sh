#!/bin/bash

set -e
bash ./01_input_checker.sh $@


basename="$1"
num_files="$2"

mkdir -p ~/apps

highest_number=0

# Ensure there's at least one file to compare
touch ~/apps/"$basename""0.log"

for file in ~/apps/"$basename"*.log; do
    filename=$(basename "$file")
    echo $filename
    number=$(echo "$filename" | sed 's/[^0-9]*//g')
    echo $number 
    if [ "$number" -gt "$highest_number" ]
    then
        highest_number="$number"
    fi
done

for ((i = highest_number + 1; i <= highest_number + num_files; i++)); do
    filename="$basename$i.log"
    touch ~/apps/"$filename"
    echo "Created $filename"
done

# The generator script must:
# 1. Generate the files to the ~/apps directory
# 2. Each file has to follow the structure of $number-$app_name.log where
#    number is a unique and incremental number. i.e payment1.log, payment2.log
# 3. The $2 parameter controls how many new files to add, respecting the current files
#    in the ~/apps directory and their numbers. i.e
#    ls ~/apps
#     payment1.log
#     payment2.log
#    Executing the script as `bash 02_generator.sh payment 3` would result in:
#    ls ~/apps
#     payment1.log
#     payment2.log
#     payment3.log
#     payment4.log
#     payment5.log
#    Executing the script one more time as `bash 02_generator.sh payment 5` would result in:
#    ls ~/apps
#     payment1.log      payment6.log
#     payment2.log      payment7.log
#     payment3.log      payment8.log
#     payment4.log      payment9.log
#     payment5.log      payment10.log
