
#!/bin/bash

set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$(basename "$0").log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p "$LOGS_FOLDER"

if [ "$USERID" -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" | tee -a "$LOGS_FILE"
    exit 1
fi

for package in "$@"
do
    dnf list installed "$package" &>>"$LOGS_FILE" || true

    if ! dnf list installed "$package" &>/dev/null; then
        echo "$package not installed, installing now"
        dnf install "$package" -y &>>"$LOGS_FILE"
    else
        echo -e "$package already installed ... $Y SKIPPING $N"
    fi
done