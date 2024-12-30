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

#check if config file for this script exists (relative to the current dir)
if ! test -e $CONFIG
then
  echo "Need $CONFIG file to proceed; see https://github.com/jgte/ssh-config-a-shell for more info."
  exit 3
fi

#install relevant packages
for i in $(cat $CONFIG)
do
  pkg list $i | grep -q $i && echo "$i is installed" || pkg install $i
done
