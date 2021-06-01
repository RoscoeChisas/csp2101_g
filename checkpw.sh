#!/bin/bash
#check all user passwords in a text file to ensure they meet the given password strength rules:

# first awk to extract only the password field from the file

awk '{ print $2 }' usrpwords.txt | awk   '{ if(NR >1) { for (i=1; i<=NF; i++)  if (length($i) > 4 && $i ~ /[A-Z]/ && $i ~ /[0-9]/) {print $i, "-" " " "meets password strength requirements " ; } else { print $i, "-" " " "does not meet password strength requirements" ;  }}}'

# NR > 1 to skip the first row i.e. the header row contains Password header
# declare for loop to parse all the rows in the given file
# if conditon to check the length and if it contains atleast 1 uppercase and number