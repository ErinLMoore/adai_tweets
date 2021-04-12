#!/bin/bash

START_DATE=$(tail -n1 dates.txt)
END_DATE=$(date -d "yesterday" +'%Y-%m-%d')
FILE_NAME="tweets/${START_DATE}_${END_DATE}.txt"

twint -u tacoblaseball --since $START_DATE -o $FILE_NAME
date -d "${END_DATE} 1 days" +%Y-%m-%d >> dates.txt

sed -i 's/.*<tacoblaseball>//g' $FILE_NAME

rg -i --passthru '^ (@\w+\s)*(ooc.+)?' -r '' $FILE_NAME | sponge $FILE_NAME
rg -i --passthru 'https://\S+\b' -r '' $FILE_NAME | sponge $FILE_NAME
rg -U --passthru  '(\r?\n)+ ' -r '\n\n' $FILE_NAME | sponge $FILE_NAME
rg --passthru  "&gt;" -r '>' $FILE_NAME | sponge $FILE_NAME
rg --passthru  "&lt;" -r '<' $FILE_NAME | sponge $FILE_NAME
rg -U --passthru  '\n{2,}' -r '\n\n' $FILE_NAME | sponge $FILE_NAME

sed -i '/^$/d' $FILE_NAME
sed -i -e 'G;' $FILE_NAME
