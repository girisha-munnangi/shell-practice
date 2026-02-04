#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "run with root privilages"
    exit 1
fi
VALIDATE(){
    if [ $1 -ne 0 ];then
        echo "$2 is fail"
        exit 1
    else 
        echo "$2 is success"
    fi
}
     
dnf install nginx -y
VALIDATE $? "installing nginx software"

dnf install mysql -y
VALIDATE $? "installing mysql software"

dnf install nodejs -y
VALIDATE $? "installing node js"


