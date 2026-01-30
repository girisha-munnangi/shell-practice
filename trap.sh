#!/bin/bash
trap 'echo "there is an error in $LINENO,command: $BASH_COMMAND"' ERR
USERID=$(id -u)
if [ $U
SERID -ne 0 ]; then
    echo "run with root privilages"
    exit 1
fi
    echo "installing nginx software"
dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "installation failed"
    exit 1
else
    echo "installation success"
fi
echo "installing mysql software"
dnf install mysql -y
if [ $? -ne 0 ];then
    echo"installation is fail"
    exit 1
else 
    echo "installation is success"
fi
    echo "installing node js"
dnf install nodejs -y
if [ $? -ne 0 ]; then
    echo "installation is fail"
    exit 1
else
    echo "installation is success"
fi

