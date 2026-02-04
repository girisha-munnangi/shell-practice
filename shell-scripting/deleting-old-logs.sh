#!/bin/bash
LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE="$LOGS_DIR/$0.log"
if [ ! -d $LOGS_DIR ]; then
    echo "$LOGS_DIR does not exists"
    exit 1
fi
FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log"-mtime 14)

while IFS= read -r filepath;do
    echo "deleting file: $filepath"
    rm -f $filepath
    echo deleted file=$filepath
    done <<< $files_to_delete