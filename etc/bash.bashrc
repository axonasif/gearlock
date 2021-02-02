# Setup env
test -d "/system/ghome" && export HOME="/system/ghome" || export HOME="/data/ghome"
export PATH="/gearlock/bin:$HOME/.local/bin:/sbin:/bin:/system/bin:/system/xbin:\
/system/vendor/bin:/apex/com.android.runtime/bin:/apex/com.android.art/bin"
: "${TERM:="linux"}"
: "${TERMINFO:="/gearlock/share/terminfo"}"
export TERM TERMINFO

if test -d "/system" && test -d "/data" && test -z "$RECOVERY"; then
	export ANDROID_ROOT="/system" ANDROID_DATA="/data"
else
	export ANDROID_ROOT="/gearlock" ANDROID_DATA="/gearlock/tmp"
fi

# When there is no ghome present
test ! -e "$HOME" && ( source /gearlock/bin/fetch )

# Extended bash history.
HISTCONTROL=ignoreboth
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT="%d/%m/%y %T "
HISTIGNORE='ls:pwd:date:cd *:'
HISTFILE="$HOME/.bash_extended_history"
PROMPT_COMMAND="updatePrompt; history -a; $PROMPT_COMMAND"
shopt -s histappend

## Convert normal bash_history into bash_extended_history if exists
test -e "$HOME/.bash_history" && test ! -e "$HOME/.bash_extended_history" && {
	mv "$HOME/.bash_history" "$HOME/.bash_extended_history"
}

# Recovery env setup
if test -n "$RECOVERY"; then
	shopt -q login_shell && {
		echo -e "You are running GearLock bash under recovery mode."
		echo -e "You can switch vt by pressing ALT + F1/2/3.\nRun \033[1;33mnewvt\033[0m command to make another virtual terminal."
		function newvt() {
			openvt -s gbash -l
		}
	}
	trap "chvt 1" EXIT
fi

# Define shell functions
function updatePrompt() {
	RETC="$?"
	test "$RETC" == "0" && PS1="\033[1;34m\u@gearlock\033[0m:\033[1;31m\w$\033[0m " \
	|| PS1="\033[1;34m\u@gearlock\033[0m:\033[1;31m\w \033[0;31m[$RETC]\033[0m$\033[0m "
}
