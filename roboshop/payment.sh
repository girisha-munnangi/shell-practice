#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD
MONGODB_HOST=mongodb.girisha.online

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
dnf install python3 gcc python3-devel -y &>>$LOGS_FILE
VALIDATE $? "installing python3 version"

id roboshop &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "creating system user"
else
    echo -e "Roboshop user already exist ... $Y SKIPPING $N"

fi
mkdir -p /app &>>$LOGS_FILE
VALIDATE $? "CREATING APP DIRECTORY"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip 
VALIDATE $? "GETTING PAYMENT CODE"
cd /app &>>$LOGS_FILE
VALIDATE $? "CHANGING DIRECTORY TO APP"
unzip /tmp/payment.zip &>>$LOGS_FILE
VALIDATE $? "UNZIPPING CODE"
cd /app 
pip3 install -r requirements.txt &>>$LOGS_FILE
VALIDATE $? "installing pip3 and dependencies"
cp $SCRIPT_DIR=$PWD/payment.service /etc/systemd/system/payment.service &>>$LOGS_FILE
systemctl daemon-reload
VALIDATE $? "deamon reload"
systemctl enable payment 
systemctl start payment
VALIDATE $? "enabling and start payment service"

