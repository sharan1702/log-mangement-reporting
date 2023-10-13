# Shell scripts to automate Log Management and Reporting with Slack 
This is a project to show the  management, reporting and notifications of logs using slack webhooks.

This project displays a way to organize, compress and rotate 3 application’s logs, reporting mechanisms and notifications about applications that are being too aggressive on disk usage. Shell Scripts have been utilized to automatically manage the entire log lifecycle including compression, organization, and automated notifications via Slack to increase the application's uptime 

# Name of the applications:
1. login
2. payment
3. order
   
# Flow:
1. Clone the repository
2. cd into the directory
3. Permission to execute scripts:  
    > chmod +x 0* 
4. Run the Generator script to create some log files 
    > ./02_generator.sh login 10
    > ./02_generator.sh payment 4
    > ./02_generator.sh order 7 
5. Compress and Delete log files
    > ./03_cleaner.sh
6. Reporting
    > ./04_reporter.sh login 10
    > ./04_reporter.sh payment 10
    > ./04_reporter.sh order 6

   <img width="491" alt="image" src="https://github.com/sharan1702/log-mangement-reporting/assets/99058879/6b724a33-c701-4cc8-8dd8-7017e331161e">

8. Notification to Slack
   > ./05_notifier.sh

   <img width="328" alt="image" src="https://github.com/sharan1702/log-mangement-reporting/assets/99058879/913f3f7e-dc15-4e7f-a07e-09491bc2061b">

