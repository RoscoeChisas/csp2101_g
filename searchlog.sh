#Name Daniel Chisasura
#Student Number 10420223
#!/bin/bash
#Purpose: Find the pattern in the server logs

#Initialize the variable flag to run the search again
flag=1

while [ $flag -eq '1' ]
do
read -p "Enter the Pattern to be searched for" PATTERN

#Ask the user for inverted match
echo "Need an inverted match(Y/N)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) grep -i -v -n "$PATTERN" access_log.txt;
#Prompt the user to search more
        echo "Need to search more (Y/N)?"
        select yn in "Yes" "No"; do
        case $yn in
            Yes ) flag=1; break 2;;
            No ) flag=0; exit;;
        esac
        done;;
#Ask for whole word or any match
        No ) echo "Need a Whole word match(Y/N)?"
  select yn in "Yes" "No"; do
          case $yn in
            Yes )grep -c -w "$PATTERN" access_log.txt|sed 's/$/ matches found /' || echo "No Matches found";grep -i -w -n "$PATTERN" access_log.txt|| echo "No matches found";
#Prompt the user to search more
      echo "Need to search more (Y/N)?"
        select yn in "Yes" "No"; do
        case $yn in
            Yes ) flag=1; break 3;;
            No ) flag=0; exit;;
        esac
        done;;
#Any match if user selects No
        No ) grep -c "$PATTERN" access_log.txt|sed 's/$/ matches found /' || echo "No Matches found";grep -i -o -n "$PATTERN" access_log.txt|| echo "No matches found"; 
#Prompt the user to search more
     echo "Need to search more (Y/N)?"
       select yn in "Yes" "No"; do
       case $yn in
            Yes ) flag=1; break 3;;
            No ) flag=0; exit;;
       esac
       done;;
         esac
  done
    esac
done
done
