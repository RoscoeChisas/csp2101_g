#!/bin/bash
#Sum of two assignment scores as they appear ordinally in separate arrays

declare -a ass1=(12 18 20 10 12 16 15 19 8 11) #declare an array name ass1
declare -a ass2=(22 29 30 20 18 24 25 26 29 30) #declare an array name ass2
sum=0 #set a variable to hold sum of two arrays of assignment scores
len=${#ass1[@]} #length of an array
for ((i=0; i<$len; i++)) #declare a for loop to run for the length of the array
 do
    sum=$(( ${ass1[$i]} + ${ass2[$i]} )) #add the values of two arrays
    echo "Student_$(($i + 1)) Result:   $sum" | column -t #echo results to the screen
     
 done 
exit 0

