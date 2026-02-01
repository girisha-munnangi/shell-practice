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

dnf module disable redis -y &>>$LOGS_FILE
VALIDATE $? "disabling redis"
dnf module enable redis:7 -y &>>$LOGS_FILE
VALIDATE $? "enabling redis"
dnf install redis -y &>>$LOGS_FILE
VALIDATE $? "installing redis"
sed -i -e 's/127.0.0.1/0.0.0.0/g' -e 'protected-mode/ c protected-mode no' /etc/redis/redis.conf
systemctl enable redis &>>$LOGS_FILE
VALIDATE $? "enabling redis"
systemctl start redis &>>$LOGS_FILE
VALIDATE $? "restating redis"

END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME - $START_TIME))
echo -e "script executed in $Y $TOTAL_TIME seconds $N"