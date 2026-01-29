#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]; then
echo "please run this scrtipt with root user access"
else
echo "installing nginx"
dnf install nginx -y
fi