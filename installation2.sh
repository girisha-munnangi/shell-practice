#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "run with root privilages"
    exit 1
fi
    echo "installing nginx software"
dnf install nginx -y
if [ $? -eq 0 ]; then
    echo "installation success"
    exit 1
else
    echo "installation failed"
fi
echo "installing mysql software"
dnf install mysql -y
if [ $? -eq 0 ];then
    echo"installation is success"
    exit 1
else 
    echo "installation is failure"
fi
    echo "installing node js"
dnf install nodejs -y
if [ $? -eq 0 ]; then
    echo "installation is success"
    exit 1
else
    echo "installation is failure"
fi