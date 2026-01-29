#!/bin/bash
NUMBER=25
if ( $NUMBER > 20 ); then
    echo "$NUMBER is greated than 20"
elif ( $NUMBER = 20 ); then
    echo "$NUMBER is equal to 20"
else
    echo "$NUMBER is less than 20"
fi