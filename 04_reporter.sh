#!/bin/bash

set -e
bash ./01_input_checker.sh $@
# The reporter script receives app_name and max_count input parameters.
# The app_name parameter controls the target application that will be evaluated for a report
# The max_count parameter controls the limit of files that are allowed for a given application.
# Example: `bash 04_reporter.sh login 10` `will generate a report if more than 10 log files
# are present for the login application.
# The reporter script must do the following to accomplish the above list of features.
# 1. Must check the number of compressed log files under ~/apps/$app/*.tar.gz based on the
#    input parameter values.
# 2. If there are no files at ~/apps/$app/*.tar.gz or the number of files is less than or equal to
#    the MAX_COUNT parameter, the script should create a file at ~/apps/$app/.report and its
#    content should be "ok" 
# 3. If the number of files is greater than the MAX_COUNT parameter, the script should create
#    a file at ~/apps/$app/.report and its content should be the number of files found.
#    For example, if MAX_COUNT = 10 and the number of files at ~/apps/$app/*.tar.gz is 20, then
#    the content of the file ~/apps/$app/.report should be 20.

APP=$1
MAX_COUNT=$2
APP_DIR=~/apps/${APP}
REPORT_PATH=$APP_DIR/.report

mkdir -p $APP_DIR
count=$(find $APP_DIR -type f -name "*.tar.gz" |wc -l)
text_report="found $count files, limit is $MAX_COUNT. Report file: $REPORT_PATH"

if [ $count -gt $MAX_COUNT ]; then
    echo "application is unhealthy : " $text_report
    echo "$count" > $REPORT_PATH
    exit 0
fi 

echo "Application is healthy: " $text_report 
echo "ok" > $REPORT_PATH # Creates the file whose content is ok