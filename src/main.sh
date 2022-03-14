use std::io::stdio;
use std::native::sleep;

function main() {
	local _internalcmd="${0##/*}";
	case "$_internalcmd" in
		gearlock|gearboot|geardump|gearinit|gearlock-cli|gearprop|gstatus)
			cmd::$_internalcmd "$@"
		;;
	esac
}

