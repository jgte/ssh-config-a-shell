# ssh-config-a-shell

This set of scripts intends to make it easy to use a synched .ss/config file in the [a-Shell iOS app](https://github.com/holzschu/a-shell).

Any prospective users should be warned that the approach implemented in these scripts is currently not working as expected.


## Install

The `install.sh` script does the following:

- call `pickFolder`, so the user can define the location of their .ssh directory, which is assumed to be synched to the iOS using another app or method.
- check that the ~/Documents/.ssh link exists, otherwise create it
- check that the .profile file includes the ssh alias `ssh -F ~/Documents/.ssh/config.a-Shell`


## Uninstall

The `uninstall.sh` script does the following:

- call `deletemark ssh` if `~ssh` exists
- check that the ~/Documents/.ssh link does not exist; otherwise, delete it
- check that the .profile file does not include the ssh alias; otherwise, remove it


## Create a-Shell friendly .ssh/config file

The `update.sh` script replaces all entries of `identityfile ~/.ssh/` with `IdentityFile ~/Documents/.ssh/` (case insensitive)

## Install packages

The `pkg-install.sh` script reads a list of packages from file `$PKG_INSTALL_LIST` and installs them if not already.

## Issues

- loading common variables from ./config.sh does not seem to work since those variables are empty right after calling that script from `install.sh`, `uninstall.sh`, `update.sh` and `pkg-install.sh`.
- the alias of `ssh` to `ssh -F ~/Documents/.ssh/config.a-Shell` is broken because it seems that the flag -F can only handle a string of limited length, and ~/Documents expands to a very long path on iOS.
