#!/bin/sh

CONFIG=config
LOCAL_SSH_SIR=~/Documents/.ssh

#make sure we're in the right place
case "$(basename $APPDIR)" in
  "a-Shell.app")
    echo "Detected a-Shell"
  ;;
  *)
    echo "ERROR: this script only makes sense to run in the a-Shell app (https://github.com/holzschu/a-shell)"
    exit 3
  ;;
esac

#check if config file for this script exists (relative to the current dir)
if ! test -e $CONFIG
then
  echo "Need $CONFIG file to proceed; see https://github.com/jgte/ssh-config-a-shell for more info."
  exit 3
fi

#check if package list is available
if grep -q PKG_LIST $CONFIG
then
  #install relevant packages
  for i in $(grep PKG_LIST | awk -F: '{print $2}')
  do
    pkg list $i | grep -q $i && echo "$i is installed" || pkg install $i
  done
else
  echo "WARNING: could not find PKG_LIST entry in $CONFIG file, skipped installing packages..."
fi

#check if ssh dir is available
if test -L $LOCAL_SSH_SIR
then
  echo "Already have link $LOCAL_SSH_SIR with target $(readlink $LOCAL_SSH_SIR)"
else
  if grep -q SSH_DIR $CONFIG
  then
    cd ~/Documents
    ln -sfv $(grep -q SSH_DIR $CONFIG) ./.ssh
  else
    echo "WARNING: could not find SSH_DIR entry in $CONFIG file, skipped linking .ssh dir..."
  fi
fi
