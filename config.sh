#!/bin/sh

export SSH_DIR=~/Documents/.ssh
export DOT_PROFILE=~/Documents/.profile
export SSH_ALIAS="alias ssh='ssh -F ~/Documents/.ssh/config.a-Shell'"
export NORMAL_SSH_CONFIG=$SSH_DIR/config
export ASHELL_SSH_CONFIG=$NORMAL_SSH_CONFIG.a-Shell
export PKG_INSTALL_LIST=pkg-install.list

echo "SSH_DIR=$SSH_DIR"
echo "DOT_PROFILE=$DOT_PROFILE"
echo "SSH_ALIAS=$SSH_ALIAS"
echo "NORMAL_SSH_CONFIG=$NORMAL_SSH_CONFIG"
echo "ASHELL_SSH_CONFIG=$ASHELL_SSH_CONFIG"
echo "PKG_INSTALL_LIST=$PKG_INSTALL_LIST"
