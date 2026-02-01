#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
START_TIME=$(date +%s)
SCRIPT_DIR=$($PWD)
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

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOGS_FILE
VALIDATE $? "copying rabbitmq repo"
dnf install rabbitmq-server -y &>>$LOGS_FILE
VALIDATE $? "installing rabbitmq server"
systemctl enable rabbitmq-server &>>$LOGS_FILE
systemctl start rabbitmq-server 
VALIDATE $? "enabilng,starting rabbitmq server"
rabbitmqctl add_user roboshop roboshop123 &>>$LOGS_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOGS_FILE
VALIDATE $? "setting up permissions"

END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME - $START_TIME))
echo -e "script executed in $Y $TOTAL_TIME seconds $N"