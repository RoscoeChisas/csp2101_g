#!/bin/bash
#find size in kilobytes, count words and last modified date of a file

read -p "Enter the File Name:" file  #user prompts for the file name

#getprop function 
getprop (){

fsize=$(du -k $file|cut -f1)  #to calculate the size of file in kilobytes

numWords=$(wc -w $file| tr -dc '0-9') #to calculate the word count in file

echo "The file $file contains $numWords words and is $fsize K in size and was last modified $(date -r $file +'%d-%m-%Y %H:%M:%S') " #it will print the message and last modified date in specific format using date command with -r option.

}

getprop $file
exit 0


