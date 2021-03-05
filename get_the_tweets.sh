#!/bin/bash

START_DATE=$(tail dates.txt)
TODAY_DATE=$(date +'%Y-%m-%d')

twint -u tacoblaseball --since $START_DATE -o "tweets/${START_DATE}_${TODAY_DATE}.txt"
echo "${TODAY_DATE}" >> dates.txt

sed -i 's/.*<tacoblaseball>//g' "tweets/${START_DATE}_${TODAY_DATE}.txt"

#.*<tacoblaseball>
#date +'%Y-%m-%d'