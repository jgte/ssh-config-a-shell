#!/bin/sh

#load relevant parameters
./config.sh

if ! test -e $NORMAL_SSH_CONFIG
then
  echo "ERROR: cannot find ssh config file '$NORMAL_SSH_CONFIG'"
  exit 3
fi

sed 's:identityfile ~/.ssh/:IdentityFile ~/Documents/.ssh/:Ig' $NORMAL_SSH_CONFIG > $ASHELL_SSH_CONFIG
