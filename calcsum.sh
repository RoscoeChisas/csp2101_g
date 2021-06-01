#Name Daniel Chisasura
#Student Number 10420223
#!/bin/bash
#Addition of numbers using default variables passed as an argument

val=$(( $1 + $2 +$3 ));
if [[ $val -lt 30 || $val -eq 30 ]]
then 
   echo "The sum of $1 and $2 and $3 is $val"
exit 0
else
   echo "Sum exceeds maximum allowable"
exit 0
fi