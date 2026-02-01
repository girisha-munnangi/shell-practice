#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
START_TIME=$(date +%s)
if [ $USERID -ne 0 ]; then
echo -e "$R please run this sccript with root user  $N" | tee -a $LOGS_FILE
exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R failure $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$2 ... $G success $N" | tee -a $LOGS_FILE
    fi
}

dnf install mysql-server -y &>>$LOGS_FILE
VALIDATE $? "INSTALLING MYSQL"

systemctl enable mysqld &>>$LOGS_FILE
systemctl start mysqld  
VALIDATE $? "enabling and starting  MYSQL service"



END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME - $START_TIME))
echo -e "script executed in $Y $TOTAL_TIME seconds $N"