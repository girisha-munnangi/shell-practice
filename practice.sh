#!/bin/bash
NUMBER=$1
if [ $NUMBER > 50 ]; then
echo "$NUMBER is greater than 50"
elif [ $NUMBER = 50 ]; then
echo "$NUMBER is equal to 50"
else
echo "$NUMBER is less than 50"
fi