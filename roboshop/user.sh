#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD
MONGODB_HOST=mongod.girisha.online

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
    fi
}

dnf module disable nodejs -y &>>$LOGS_FILE
dnf module enable nodejs:20 -y
VALIDATE $? "disabling and enabling nodejs versions"
dnf install nodejs -y
VALIDATE $? "installing nodejs"

id roboshop &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "creating system user"
else
    echo -e "Roboshop user already exist ... $Y SKIPPING $N"

fi
mkdir /app &>>$LOGS_FILE
VALIDATE $? "CREATING APP FOLDER"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip &>>$LOGS_FILE
VALIDATE $? "getting user service code"
cd /app 
VALIDATE $? "Changing to app directory"
unzip /tmp/user.zip
VALIDATE $? "unzipping the user zip code"
cd /app 
npm install &>>$LOGS_FILE
VALIDATE $? "installing npm"

cp $CRIPT_DIR/user.service /etc/system/systemd/user.service
VALIDATE $? "copying user service file"
systemctl daemon-reload &>>$LOGS_FILE
VALIDATE $? "deamon reload"
systemctl enable user &>>$LOGS_FILE
systemctl start user &>>$LOGS_FILE
VALIDATE $? "enable and starting the user service "