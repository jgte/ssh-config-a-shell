#!/bin/sh

#load relevant parameters
./config.sh
#show their values
echo "SSH_DIR=$SSH_DIR"
echo "DOT_PROFILE=$DOT_PROFILE"
echo "SSH_ALIAS=$SSH_ALIAS"
echo "NORMAL_SSH_CONFIG=$NORMAL_SSH_CONFIG"
echo "ASHELL_SSH_CONFIG=$ASHELL_SSH_CONFIG"
echo "PKG_INSTALL_LIST=$PKG_INSTALL_LIST"
#sanitize
if test -z "$SSH_DIR"
then
  echo "FATAL: could not load config.sh"
  exit 3
fi

#check if config file for this script exists (relative to the current dir)
if ! test -e $PKG_INSTALL_LIST
then
  echo "Need $PKG_INSTALL_LIST file to proceed; see https://github.com/jgte/ssh-config-a-shell for more info."
  exit 3
fi

#install relevant packages
for i in $(cat $PKG_INSTALL_LIST)
do
  pkg list $i | grep -q $i && echo "$i is installed" || pkg install $i
done
