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

export SSH_DIR=~/Documents/.ssh
export DOT_PROFILE=~/Documents/.profile
export SSH_ALIAS="alias ssh='ssh -F ~/Documents/.ssh/config.a-Shell'"
export NORMAL_SSH_CONFIG=$SSH_DIR/config
export ASHELL_SSH_CONFIG=$NORMAL_SSH_CONFIG.a-Shell
export PKG_INSTALL_LIST=pkg-install.list
