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
MSG="deletemark to delete ~ssh link"
if ! test -d ~ssh
then
  echo "Already removed $MSG"
else
  echo "Pick the location of the .ssh dir, outside a-Shell"
  deletemark ssh
  if ! test -d ~ssh
  then
    echo "ERROR: cannot delete bookmark ~ssh"
    exit 3
  fi
  echo "Successfully called $MSG"
fi

#check if link to ssh dir is available in $SSH_DIR
MSG="link $SSH_DIR (~/Documents/.ssh) with target $(readlink $SSH_DIR) (~ssh)"
if test -z "$SSH_DIR" || ! test -L $SSH_DIR
then
  echo "Already removed $MSG"
else
  rm -fv $SSH_DIR
  echo "Removed $MSG"
fi

#patch .profile
MSG=".profile of ssh alias"
if test -e $DOT_PROFILE
then
  if grep -q "$SSH_ALIAS" $DOT_PROFILE
  then
    echo "Cleaning $MSG"
    cp $DOT_PROFILE $DOT_PROFILE.bup
    grep -v $SSH_ALIAS $DOT_PROFILE > $DOT_PROFILE.tmp && mv -fv $DOT_PROFILE.tmp $DOT_PROFILE
  else
    echo "Already cleaned $MSG"
  fi
else
  echo "No .profile found, nothing to do"
fi
