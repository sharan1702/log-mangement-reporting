#!/bin/bash

set -e
# The notifier scripts tries to find any .report files under ~/apps/$app and
# sends a consolidated slack message with the application status.
# To accomplish this, the script must:
# 1. If any .report file is found, the script has to extract the application
#    name from the directory. Example: ~/apps/login/.report would extract login
#    as the application name
# 2. If the content of the .report file is ok, then the slack text message should be:
#    Application $app is healthy.
# 3. If the content of the .report file is something other than ok, the message should be:
#    Application $app is unhealthy. Current log count is $content.


report_files=$(find ~/apps/ -type f -name ".report")
if [ -z "$report_files" ]; then
    echo "No report files were found. Did you run the 04_reporter.sh script?"
    exit 0 # Exits the script
fi

# echo $report_files
text=""

for i in $report_files; do
    app=$(basename $(dirname $i))
    # echo "Name of application: $app"
    if grep "ok" $i; then
        text+="Application \'$app\' is healthy! :white_check_mark: \n"
    else
        text+="Application \'$app\' is unhealthy. Current log count is \'$(cat $i)\' :warning: \n"
    fi
done

SLACK_JSON_FILE=slack.json 
cat <<EOF >$SLACK_JSON_FILE
{
    "attachments": [
        {
            "fallback": "Report",
            "color": "#0000FF",
            "pretext": ":notebook: Logging report:",
            "text": "$text"
        }
    
    ]
}

EOF

curl -X POST -d @$SLACK_JSON_FILE https://hooks.slack.com/services/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

echo -e "\nSuccessfully sent a report to slack."