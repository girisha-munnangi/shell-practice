#!/bin/bash
NUMBER=25
if [ $NUMBER -gt 20]; then
    echo "$NUMBER is greated than 20"
elif [ $NUMBER -eq 20]; then
    echo "$NUMBER is equal to 20"
else
    echo "$NUMBER is less than 20"
fi