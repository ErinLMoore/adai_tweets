#!/bin/bash

START_DATE=$(tail -n1 dates.txt)
END_DATE=$(date +'%Y-%m-%d')
FILE_NAME="tweets/${START_DATE}_${END_DATE}.txt"

twint -u tacoblaseball --since $START_DATE -o $FILE_NAME
date -d "${END_DATE} 1 days" +%Y-%m-%d >> dates.txt

sed -i 's/.*<tacoblaseball>//g' $FILE_NAME

#.*<tacoblaseball>
#date +'%Y-%m-%d'