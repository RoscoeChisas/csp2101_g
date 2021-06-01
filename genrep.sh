#!/bin/bash
#script to extract the required data from attacks.html using grep, sed and awk commands.

echo "Attacks Type    Instances(Q3)"

grep '^<tr><td>' < attacks.html \
| sed \
   -e 's:<tr>::g'  \
  -e 's:</tr>::g' \
    -e 's:</td>::g' \
-e 's:<td>: :g' \
| cut -c2-| awk '{  sum=0; for (i=1; i<=NF; i++) { sum+= $i } print $1 "\t" "\t" sum}'  #awk command to loop from all the rows and do addition of attacks instances for 3 months


