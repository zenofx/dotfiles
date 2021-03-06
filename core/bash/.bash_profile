# shellcheck shell=bash

# DEBUG
if [[ -e "${XDG_CONFIG_HOME}/profile/_debug" ]]; then
	printf '%d%s\n' "${EPOCHSECONDS}" ': .bash_profile' >> "${XDG_RUNTIME_DIR:-/run/user/${LOGNAME}}/profile_dbg.log"
fi

# load .profile since .bash_profile takes priority
if [[ -f ~/.profile && -z $PROFILE_SOURCED ]]; then
	source ~/.profile
fi

# load .bashrc for aliases and functions in login shells
if [[ -f ~/.bashrc ]]; then
	source ~/.bashrc
fi

# vim: ft=bash ts=4 sw=4 noet
