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
