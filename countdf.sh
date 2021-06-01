#Name Daniel Chisasura
#Student Number 10420223
#!/bin/bash
#Purpose: Count empty and non-empty files and directories

read -p "Enter the directory path" LOCATION
FFILECOUNT=0
EFILECOUNT=0
FDIRCOUNT=0
EDIRCOUNT=0
#For loop to iterate all the items inside the directory
for item in $LOCATION/* $LOCATION/.*
do
if [ -f "$item" ] ;
then
   if [ -s "$item" ];
    then
     ((FFILECOUNT=FFILECOUNT + 1 ));
   else
     ((EFILECOUNT=EFILECOUNT + 1 ));
   fi
fi
if [ -d "$item" ] ;
then
  if [ ls -a "$item" ];
   then
    ((FDIRCOUNT= FDIRCOUNT + 1 )) ;
  else
    ((EDIRCOUNT= EDIRCOUNT + 1 )) ;
  fi
fi
done
echo "The $LOCATION directory contains:"
echo $FFILECOUNT "files that contain data" ;
echo $EFILECOUNT "files that are empty" ;
echo $FDIRCOUNT "non-empty directories" ;
echo $EDIRCOUNT "empty directories" ;

