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

#check if ssh dir has already been picked
MSG="pickFolder to create ~ssh link"
if test -d ~ssh
then
  echo "Already called $MSG"
else
  pickFolder
  if test -d ~ssh
  then
    echo "ERROR: cannot find ~ssh dir, which will appear once you pick the .ssh dir"
    exit 3
  fi
  echo "Successfully called $MSG"
fi

#check if link to ssh dir is available in $SSH_DIR
MSG="link $SSH_DIR (~/Documents/.ssh) with target $(readlink $SSH_DIR) (~ssh)"
if test -L $SSH_DIR
then
  echo "Already have $MSG"
else
  cd ~/Documents
  ln -sfv ~ssh .ssh
  cd - > /dev/null
  echo "Created $MSG"
fi

#patch .profile
MSG=".profile with ssh alias"
if test -e $DOT_PROFILE
then
  if grep -q "$SSH_ALIAS" $DOT_PROFILE
  then
    echo "Already have $MSG"
  else
    echo "Appending $MSG"
    echo "$SSH_ALIAS" >> $DOT_PROFILE
  fi
else
  echo "Creating $MSG"
  echo "$SSH_ALIAS" > $DOT_PROFILE
fi
