#!/bin/bash
# -*- coding: utf-8; tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-

# autopatch.sh: script to manage patches on top of repo
# Copyright (c) 2018, Intel Corporation.
# Author: sgnanase <sundar.gnanasekaran@intel.com>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.

top_dir=`pwd`
utils_dir="$top_dir/vendor/gearlock"
private_utils_dir="$tutils_dir/private"
private_patch_dir="$private_utils_dir/patches/google_diff/$TARGET_PRODUCT"

# Device type selection
PS3='Which Android version are you building?: '
options=("Android 7"
		 "Android 8"
		 "Android 9"
		 "Android 10")
select opt in "${options[@]}"
do
	case $opt in
		"Android 7")
			echo "you chose choice $REPLY which is $opt"
			ANDROID_MAJOR_VERSION="android-7"
			break
			;;
		"Android 8")
			echo "you chose choice $REPLY which is $opt"
			ANDROID_MAJOR_VERSION="android-8"
			break
			;;
		"Android 9")
			echo "you chose choice $REPLY which is $opt"
			ANDROID_MAJOR_VERSION="android-9"
			break
			;;
		"Android 10")
			echo "you chose choice $REPLY which is $opt"
			ANDROID_MAJOR_VERSION="android-10"
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done


patch_dir="$utils_dir/patches/$ANDROID_MAJOR_VERSION"

current_project=""
previous_project=""
conflict=""
conflict_list=""

apply_patch() {

  pl=$1
  pd=$2

  echo ""
  echo "Applying Patches"

  for i in $pl
  do
    current_project=`dirname $i`
    if [[ $current_project != $previous_project ]]; then
      echo ""
      echo ""
      echo "Project $current_project"
    fi
    previous_project=$current_project

    cd $top_dir/$current_project
    remote=`git remote -v | grep "https://android.googlesource.com/"`
    if [[ -z "$remote" ]]; then
      default_revision="remotes/m/master"
    else
      if [[ -f "$top_dir/.repo/manifest.xml" ]]; then
        default_revision=`grep default $top_dir/.repo/manifest.xml | grep -o 'revision="[^"]\+"' | cut -d'=' -f2 | sed 's/\"//g'`
      else
        echo "Please make sure .repo/manifest.xml"
        # return 1
      fi
    fi

    cd $top_dir/$current_project
    a=`grep "Date: " $pd/$i`
    b=`echo ${a#"Date: "}`
    c=`git log --pretty=format:%aD | grep "$b"`

    if [[ "$c" == "" ]] ; then
      git am -3 $pd/$i >& /dev/null
      if [[ $? == 0 ]]; then
        echo "        Applying          $i"
      else
        echo "        Conflicts          $i"
        git am --abort >& /dev/null
        conflict="y"
        conflict_list="$current_project $conflict_list"
      fi
    else
      echo "        Already applied         $i"
    fi
  done
}

#Apply common patches
cd $patch_dir
patch_list=`find * -iname "*.patch" | sort -u`
apply_patch "$patch_list" "$patch_dir"

#Apply Embargoed patches if exist
if [[ -d "$private_patch_dir" ]]; then
    echo ""
    echo "Embargoed Patches Found"
    cd $private_patch_dir
    private_patch_list=`find * -iname "*.patch" | sort -u`
    apply_patch "$private_patch_list" "$private_patch_dir"
fi

echo ""
if [[ "$conflict" == "y" ]]; then
  echo "==========================================================================="
  echo "           ALERT : Conflicts Observed while patch application !!           "
  echo "==========================================================================="
  for i in $conflict_list ; do echo $i; done | sort -u
  echo "==========================================================================="
  echo "WARNING: Please resolve Conflict(s). You may need to re-run build..."
  # return 1
else
  echo "==========================================================================="
  echo "           INFO : All patches applied fine !!                              "
  echo "==========================================================================="
fi
