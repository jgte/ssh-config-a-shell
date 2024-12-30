#!/bin/sh

#make sure we're in the right place
case "$(basename ${APPDIR:-empty})" in
  "a-Shell.app")
    echo "Detected a-Shell"
  ;;
  *)
    echo "ERROR: this script only makes sense to run in the a-Shell app (https://github.com/holzschu/a-shell)"
    exit 3
  ;;
esac

#load relevant parameters
./config.sh

if ! test -e $NORMAL_SSH_CONFIG
then
  echo "ERROR: cannot find ssh config file '$NORMAL_SSH_CONFIG'"
  exit 3
fi

sed 's:identityfile ~/.ssh/:IdentityFile ~/Documents/.ssh/:Ig' $NORMAL_SSH_CONFIG > $ASHELL_SSH_CONFIG
