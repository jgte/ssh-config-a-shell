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

if ! test -e $NORMAL_SSH_CONFIG
then
  echo "ERROR: cannot find ssh config file '$NORMAL_SSH_CONFIG'"
  exit 3
fi

sed 's:identityfile ~/.ssh/:IdentityFile ~/Documents/.ssh/:Ig' $NORMAL_SSH_CONFIG > $ASHELL_SSH_CONFIG
