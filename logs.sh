#!/bin/bash
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"
mkdir -p "$LOG_FOLDER"

if [ $USERID -ne 0 ]; then
    echo "run with root privilages" | tee -a $LOGS_FILE
    exit 1
fi 

VALIDATE(){
    if [ $1 -ne 0 ];then
        echo "$2 is fail"  | tee -a $LOGS_FILE
        exit 1
    else 
        echo "$2 is success"    | tee -a $LOGS_FILE
    fi
}
     
dnf install nginx -y &>> $LOGS_FILE
VALIDATE $? "installing nginx software"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "installing mysql software"

dnf install nodejs -y &>> $LOGS_FILE
VALIDATE $? "installing node js"