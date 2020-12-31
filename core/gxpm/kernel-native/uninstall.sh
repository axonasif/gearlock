## For proper developer documentation, visit https://supreme-gamers.com/gearlock
# GEN_UNINS is enabled for this prebuild-kernel package (Check `!zygote.sh`).
#
# Which will log all the files present inside your package `system` dir
# and merge that as a function with your custom `uninstall.sh`.
#
# You don't need to modify this `uninstall.sh`.
# 
# $UNINS_SCRIPT variable is provided by GXPM which returns
# full path for the locally prepared uninstallation script.

# Define variables
TTY_NUM="$(fgconsole)"
FIRMDIR="$SYSTEM_DIR/lib/firmware"
FIRMDIR_OLD="$FIRMDIR.old"
FIRMDIR_UPDATE="$FIRMDIR.update"
DALVIKDIR="/data/dalvik-cache"
EFFECTIVE_FIRMDIR_PLACEHOLDER="$FIRMDIR/effective-kernel"
RESCUE_KERNEL_IMAGE="$GRROOT/rescue-kernel"
GBSCRIPT[1]="$GBDIR/init/UpdateKernelFirmware"
GBSCRIPT[2]="$GBDIR/init/ClearDalvikForKernelUpdate"

# Define functions
handleError ()
{ 
	if [ $? != 0 ]; then
		geco "\n[!!!] Error: $1" && return ${2:-101}
	fi
}

# Deny uninstallation from GUI to avoid system crash
if [ "$TERMINAL_EMULATOR" == "yes" ]; then
	geco "\n+ You can not uninstall kernel from Android GUI, it will crash your system."
	geco "+ It is not recommended that you uninstall from a live system, best practice is to uninstall from RECOVERY-MODE."
	geco "+ You can still run GearLock in ${PURPLE}TTY${RC} and uninstall from there but it's not recommended.\n"
	while true
	do
		read -rn1 -p "$(geco "Do you want to switch to ${BGREEN}TTY${RC} and uninstall from there ? [${GREEN}Y${RC}/n]") " i
		case $i in
					
			[Yy] ) geco "\n\n+ Switching to TTY GearLock GXPM ..." && sleep 2
					gsudo openvt -s gxpm -u "$UNINS_SCRIPT"; return 101; break ;;
						
			[Nn] ) geco "\n\n+ Okay, uninstallation process will exit"
					return 101; break ;;
						
				*) geco "\n- Enter either ${GREEN}Y${RC}es or no" ;;
					
		esac
	done
fi

# Check if the user is running uninstall right after installation without reboot (For GUI installation)
if test -e "$FIRMDIR_UPDATE"; then rm -r "$FIRMDIR_UPDATE"; handleError "Failed to cleanup $(basename "$FIRMDIR_UPDATE")"; fi
rm -f "${GBSCRIPT[1]}" "${GBSCRIPT[2]}"

# Restore stock kernel image
if [ -f "$RESCUE_KERNEL_IMAGE" ]; then
	geco "\n+ Restoring stock kernel image ..." && sleep 1
	nout mv "$RESCUE_KERNEL_IMAGE" "$KERNEL_IMAGE"; handleError "Failed to restore stock kernel image"
fi

# Restore stock modules/firmware dir
if [ -d "$FIRMDIR_OLD" ] && [ "$(cat "$EFFECTIVE_FIRMDIR_PLACEHOLDER")"  == "${NAME}_${VERSION}" ]; then
	geco "\n+ Restoring stock "$(basename "$FIRMDIR")" ..."
	nout rm -r "$FIRMDIR" && mv "$FIRMDIR_OLD" "$FIRMDIR"; handleError "Failed to restore stock "$(basename "$FIRMDIR")""
fi

# Clear dalvik-cache
test -d "$DALVIKDIR" && geco "\n+ Clearing dalvik-cache, it may take a bit long on your next boot ..." && rm -rf "$DALVIKDIR"/*
# A workaround to retrun back to initial tty when booted android system crashes and switches to tty7
test "$BOOTCOMP" == "yes" && (while sleep 2; do test "$(fgconsole)" != "$TTY_NUM" && chvt "$TTY_NUM"; done) &
