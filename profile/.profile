# ~/.profile
# assume bash compatible shell
# this file must get sourced by a shell specific profile (ZSH: .zprofile, bash: .bash_profile)
#  you may link this to .xprofile aswell

# let's be explicit here
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
if [[ -d "${HOME}/tmp" ]]; then
	XDG_CACHE_HOME="${HOME}/tmp/.cache"
else
	XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
fi
export XDG_CACHE_HOME
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}

# define additional PATH folders here
pathar=("${XDG_DATA_HOME}/../bin")
##
# PATH handling
if type realpath >/dev/null 2>&1; then
	for (( i=0; i < ${#pathar[@]}; i++ )); do
		pathar[$i]="$(realpath -s "${pathar[$i]}")"
	done
	unset i
fi
if [[ -n "$ZSH_VERSION" ]]; then
	emulate zsh -c 'path=($pathar $path)'
else
	path=("${pathar[@]}" "$PATH")
	path="$( printf '%s:' "${path[@]%/}" )"
	path="${path:0:-1}"
	export PATH="$path"
	unset path
fi
unset pathar

# default applications by env
export EDITOR=nvim
export SUDO_EDITOR='nvim -Z -u /dev/null'
export ALTERNATE_EDITOR=vim
export VISUAL=$EDITOR
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESSHISTFILE="${XDG_CACHE_HOME}/lesshist"

# maybe these should be in .zprofile, but terminal emulators unter lightdm/i3
# are not sourcing .zprofile/started as a login shell as it seems
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"

[[ -d $ZSH_CACHE_DIR ]] || mkdir -p $ZSH_CACHE_DIR

MACHINE=${HOST:-$HOSTNAME}
if [[ ! -z ${MACHINE+x} ]]; then
	if [[ -r "${HOME}/.profile-${MACHINE}" ]]; then
		source "${HOME}/.profile-${MACHINE}"
	elif [[ -r "${XDG_CONFIG_HOME}/profile/profile-${MACHINE}" ]]; then
		source "${XDG_CONFIG_HOME}/profile/profile-${MACHINE}"
	fi
fi
#EOF