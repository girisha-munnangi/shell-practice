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
DAYS=${3:-14} #here 14 days is deafault if user didn't specified
if [ $USER_ID -ne 0 ]; then
    echo "run script with root user "
fi
mkdir -p $LOGS_FOLDER
log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
}
USAGE(){
    echo "USAGE:: sudo backup <source_dir> <desti_dir> <days>[default 14 days]"
    exit 1
}
if [ $# -lt 2 ]; then
    USAGE
fi
if [ ! -d $SOURCE_DIR ]; then
    echo "source directory $SOURCE_DIR doesn't exist"
    exit 1
fi
if [ ! -d $DEST_DIR ]; then
    echo "destination directory $DEST_DIR doesn't exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)
log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"
if [ -z $FILES ]; then
    log "no files to archive skipping "
else
    log "files found to archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
    log "archieve name : $ZIP_FILE_NAME"
    tar -cvf $ZIP_FILE_NAME $FILES

    if [ -f $ZIP_FILE_NAME ]; then
        log "Archeival is ... $G SUCCESS $N"

        while IFS= read -r filepath; do
        # Process each line here
        log "Deleting file: $filepath"
        rm -f $filepath
        log "Deleted file: $filepath"
        done <<< $FILES
        else
        log "Archeival is ... $R FAILURE $N"
        exit 1
    fi
fi