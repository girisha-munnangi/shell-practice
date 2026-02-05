#!/bin/bash
USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/backup.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2
if [ $USER_ID -ne 0 ]; then
    echo "run script with root user "
fi
mkdir $LOGS_FOLDER
USAGE(){
    echo "USAGE:: sudo backup <source_dir> <desti_dir> <days>[default 14 days]"
    exit 1
}
if [ $# -lt 2 ]; then
    USAGE
fi
if [ ! -d $SOURCE_DIR ]; then
    echo "$SOURCE_DIR doesn't exist"
    exit 1
fi
if [ ! -d $DEST_DIR ]; then
    echo "$DEST_DIR doesn't exist"
    exit 1
fi