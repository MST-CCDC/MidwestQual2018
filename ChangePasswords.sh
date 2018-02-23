#!/bin/bash
# This script is used to change all of the user accounts (minus the one calling this
# script on this computer and root) to the value $password with the user name capitalized and
# appended to the end
if [ $(id -u) -ne 0 ]; then
  echo "Please run as root"
  exit
fi

cut -d: -f1 /etc/passwd > userNames.txt

password="DontLogInto"

while read userName; do
  if [ "$userName" != "$SUDO_USER" ] && [ $(id -u $userName) -eq 0 ]; then
    tempPass=$password$(echo $userName | tr [a-z] [A-Z])
    echo "$userName:$tempPass" | chpasswd
  fi
done < userNames.txt

rm userNames.txt
