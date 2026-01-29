#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]; then
echo "run with root privilages"
else
echo "installing nginx software"
dnf install nginx -y
fi
if [ $? -eq 0 ]; then
echo "installation success"
else
echo "installation failed"
fi