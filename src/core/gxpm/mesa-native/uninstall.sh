## Ready to use mesa uninstallation script by @AXON
## For proper developer documentation, visit https://supreme-gamers.com/gearlock
# You don't need to modify this `uninstall.sh`.
# 
# $UNINS_SCRIPT variable is provided by GXPM which returns
# full path for the locally prepared uninstallation script.


# Define vars
TTY_NUM="$(fgconsole)"
DALVIKDIR="/data/dalvik-cache"
GBSCRIPT="$GBDIR/init/UpdateMesa"
MESA_BACKUP_FILE="$STATDIR/mesa_stock.bak"

# Define functions
handleError ()
{ 

	if [ $? != 0 ]; then
		# TODO: Revert back any incomplete changes
		geco "\n[!!!] Error: $1" && return ${2:-101}
	fi

}

mesa_native()
{
	
	"$CORE/gxpm/mesa-native/job" "$@"
	
}

# Deny uninstallation from GUI to avoid system crash
if [ "$TERMINAL_EMULATOR" == "yes" ]; then
	geco "\n+ You can not uninstall Mesa from Android GUI, it will crash your system."
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

# A workaround to retrun back to initial tty when booted android system crashes and switches to tty7
test "$BOOTCOMP" == "yes" && (while sleep 2; do test "$(fgconsole)" != "$TTY_NUM" && chvt "$TTY_NUM"; done) &

# Check if /system is writable
! touch -c "$SYSTEM_DIR/lib" >/dev/null 2>&1 && geco "[!!!] $SYSTEM_DIR is not writable, did you ${PINK}SuperCharge${RC} it yet ?" && exit 101

# Check for backup archive existence
test -e "$MESA_BACKUP_FILE"; handleError "Mesa backup archive not found"

# Cleanup mesa
geco "\n+ Cleaning up current Mesa dri & dependencies ..." && mesa_native clean

# Restore backup mesa
geco "\n+ Restoring stock Mesa from backup archive ..."
tar --zstd --strip-components=1 --warning=no-timestamp --directory="$SYSTEM_DIR" -xpf "$MESA_BACKUP_FILE"; handleError "Failed to restore stock Mesa from backup archive"

# Clear dalvik-cache
test -d "$DALVIKDIR" && geco "\n+ Clearing dalvik-cache, it may take a bit long on your next boot ..." && rm -rf "$DALVIKDIR"/*

# Remove any existing UpdateMesa job
rm -rf "$GBSCRIPT" "$STATDIR/UpdateMesa"
