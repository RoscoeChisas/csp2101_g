#Name Daniel Chisasura
#Student Number 10420223
#!/bin/bash
#Purpose: Prompt the user for valid input and keep prompting until valid input has been made.
flag=1

#While loop: To prompt the user until valid input entered
while [ $flag -eq 1 ]
do
#Read the input
read -p "Enter value:" val

#check whether input is an integer
if [[ $val =~ ^[0-9]*$ ]]
then
#check whether input is 20 or 40
  if [[ $val -eq 20 || $val -eq 40 ]]
    then 
     echo "Valid Input"
     flag=0
     exit 0
  else
     flag=1
     echo "Invalid Input: Please enter expected integer"
  fi
else
flag=1
echo "Invalid Input: Please enter an integer"
fi
done