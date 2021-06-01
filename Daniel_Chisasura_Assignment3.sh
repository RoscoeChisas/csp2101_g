#Daniel Chisasura
#Student Number 10420223
#!/bin/bash
<<Block_comment
  user asked to search in whole directory or in specific file.
  1.) If User selects 1 then it will search all the log files in current directory.
  2.) If user selects 2 then it will ask to enter log file name in which he wants to search
Block_comment
echo "Want to Search in whole directory (Y/N)?"
        select yn in "Yes" "No"; do
        case $yn in
            Yes )  dire="*"; break 1;;
            No ) read -p "Enter the log file name in which you want to search " dire ; break 1;;
        esac
        done
# User prompts to enter output file name        
read -p "Enter the output file in which you want to store output " Result
#Select Menu Option has been created
#PS3 (Prompt String) prompt is useful in shell scripts along with select command to provide a custom prompt for the user to select a value
PS3="Choose How you want to search (1(Pac & Bytes) /2(IPs) /3(Misc) /4 (Protocol) /5 (Feature) /6 (Quit)): "
options=("Search using Packets and Bytes" "Search using SRC IP and Dest IP" "MISC SEARCH" "Search by Protocol" "Additional Feature" "Quit" )
select menu in "${options[@]}";
do

 case $menu in
        "Search using Packets and Bytes")
            #PS3="what choice: "
signs=(">=" "<=" "==")
echo "Choose operator"
select value in "${signs[@]}";
do
 IFS=","
# Enter 2 inputs with comma as separotor i.e. packets and bytes 
while read -a  arr2
#first input of array storing in pac variable
  pac=$(echo "${arr2[0]}"| cut -d'.' -f 1);
#second input of array storing in byt variable
  byt=$(echo "${arr2[1]}"| cut -d'.' -f 1);
  do
   
  case $value in
  ">=")
  <<Block_comment
  1.)awk command first to output only data in which Class is suspicios.
  2.)awk command after pipeline operator to check 8th and 9th column which stores packets and bytes to compare with inputs and then do their total also at last
Block_comment
  awk -F "," '{if(/suspicious/ ) {print; }}' $dire| awk -F "," -v var1="$pac" -v var2="$byt" '{ if($8>=var1 && $9>=var2) {sump+=$8;sumb+=$9; print;} } END{print sump, sumb;}' > $Result
  #break this case then continue to prompt the user to search again
 break ;
 ;;
 "<=")
 #Similarly to above but for less than operator
 awk -F "," '{if(/suspicious/ ) {print; }}' $dire|awk -F "," -v var1="$pac" -v var2="$byt" '{ if($8<=var1 && $9<=var2) {sump+=$8;sumb+=$9; print;} } END{print sump, sumb;}'  > $Result
 break ;
 ;;
 "==")
 #Similarly to above but for equal to operator
awk -F "," '{if(/suspicious/ ) {print; }}' $dire| awk -F "," -v var1="$pac" -v var2="$byt" '{ if($8==var1 && $9==var2) {sump+=$8;sumb+=$9; print;} } END{print sump, sumb;}'  > $Result
 break ;
 ;;
 
 esac
done
 
 continue 5;
done
            ;;
        "Search using SRC IP and Dest IP")
        # multiple inputs should be comma separator 
            IFS=","
#Taking input in an array
while read -a  arr1
do
#calculating length of an array
lent=${#arr1[@]}
#extract first input of array in variable
vart=$(echo "${arr1[0]}"| cut -d'.' -f 1);
#If length is greater than 1
if(( $lent >1 ))
then
#extract second input in variable
vart2=$(echo "${arr1[1]}"| cut -d'.' -f 1);
<<Block_comment
  1.)awk command first to output only data in which Class is suspicios.
  2.)awk command after pipeline operator to check 4th and 6th column which stores SRC IP and Dest IP to compare with input strings and then stores output in output file 
  3.) IGNORECASE =1 to make the serach case insensitive
Block_comment
awk -F "," '{if(/suspicious/ ) {print; }}' $dire|awk -F "," -v var3="$vart" -v var4="$vart2" '{IGNORECASE=1; if(($4 ~ var3) && ($6 ~ var4)) {print; }}'  > $Result

else
# awk command to check if either SRC IP or DEST Ip came in input
awk -F "," '{if(/suspicious/ ) {print; }}' $dire|awk -F "," -v var3="$vart"  '{ IGNORECASE=1; if($4 ~ var3 || $6 ~ var3)  {print; }}'  > $Result
fi
   
   break 1;
done
            ;;
    # Search on the basis of any of the 3 inputs        
        "MISC SEARCH")
       
IFS=","
while read -a arr
do
len=${#arr[@]}
if(( $len ==3 ))
then
#extracting array inputs in variables if length is 3
vart3=$(echo "${arr[0]}"| cut -d'.' -f 1);
vart4=$(echo "${arr[1]}"| cut -d'.' -f 1);
vart5=$(echo "${arr[2]}"| cut -d'.' -f 1);

<<Block_comment
  1.)awk command first to output only data in which Class is suspicios.
  2.)awk command after pipeline operator to search all the columns of log file for any random input pattern given by user
  3.) IGNORECASE =1 to make the serach case insensitive
Block_comment
awk -F "," '{if(/suspicious/ ) {print; }}' $dire |awk -F "," -v var5="$vart3" -v var6="$vart4" -v var7="$vart5" '{IGNORECASE=1;  for (j=1; j<=NF; j++) {  if ($j ~ var5 || $j ~ var6 || $j ~ var7 ) { print; } }}'  > $Result

elif(($len ==2))
then
vart6=$(echo "${arr[0]}"| cut -d'.' -f 1);
vart7=$(echo "${arr[1]}"| cut -d'.' -f 1);
awk -F "," '{if(/suspicious/ ) {print; }}' $dire |awk -F "," -v var8="$vart6" -v var9="$vart7"  '{  for (j=1; j<=NF; j++) {IGNORECASE=1;  if ($j ~ var8 || $j ~ var9  ) { print; } }}'  > $Result
elif(($len ==1))
then
vart8=$(echo "${arr[0]}"| cut -d'.' -f 1);
awk -F "," '{if(/suspicious/ ) {print; }}' $dire |awk -F "," -v var10="$vart8"   '{ IGNORECASE=1; for (j=1; j<=NF; j++) {  if ($j ~ var10) { print; } }}'  > $Result

 fi
    
   break 1;
done

;;
    "Search by Protocol")
    read -r -p "Enter the Protocol" PRC
    #Validating input if Protocol name contains only alphabets
    if [[ $PRC =~ ^[a-zA-Z]+$ ]];then
     awk -F "," '{if(/suspicious/ ) {print; }}' $dire| awk -F "," -v varp="$PRC"  '{ IGNORECASE=1; if($3 ~ varp)  {print; }}' > $Result
   
     else
 #User will be prompted invalid input and ask to search again
     echo "Invalid Input. Please enter correct protocol name";
     fi
         continue 6;
         ;;        
    "Additional Feature")
    <<Block_comment
   1.) This Feature is to show the output on the screen in colored format
   2.) User can enter the output which he wants to show in different co
Block_comment
  
read -r -p "Show the protocol entries in Yellow" PRT
        awk -F "," '{if(/suspicious/ ) {print; }}' $dire| awk -F "," -v varf="$PRT" '{ IGNORECASE=1; if($3 ~ varf)  {print "\033[33;1m" $3; }}' 
         continue 6;
         ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
 done