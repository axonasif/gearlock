rompath=$(pwd)

#setup colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`
teal=`tput setaf 6`
light=`tput setaf 7`
dark=`tput setaf 8`
CL_CYN=`tput setaf 12`
CL_RST=`tput sgr0`
reset=`tput sgr0`


function apply-gearlock-patches()
{
	if [ -f "${rompath}/bootable/newinstaller/initrd/scripts/0-hook" ]; then 
		if [ "$(sha256sum vendor/gearlock/hook | cut -d ' ' -f1)" != "$(sha256sum bootable/newinstaller/initrd/scripts/0-hook | cut -d ' ' -f1)" ]; then
			echo "Gearlock Hook is different, updating that for you"
			cp -p ${rompath}/vendor/gearlock/hook ${rompath}/bootable/newinstaller/initrd/scripts/0-hook
		else
			echo "Gearlock Hook already up to date"
		fi
		cd ${rompath}/bootable/newinstaller
		git add -A && git commit -am "Update Gearlock Hook" --author="Jon West <electrikjesus@gmail.com>"
		cd $rompath
	else
		echo "No Gearlock Hook found. Copying now"
		cp -p ${rompath}/vendor/gearlock/hook ${rompath}/bootable/newinstaller/initrd/scripts/0-hook
		cd ${rompath}/bootable/newinstaller
		git add -A && git commit -am "Update Gearlock Hook" --author="Jon West <electrikjesus@gmail.com>"
		cd $rompath
		${rompath}/vendor/gearlock/autopatch.sh
	fi
	
	
}
