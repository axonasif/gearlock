# Introduction [![Build Status](https://travis-ci.com/AXIM0S/gearlock.svg?branch=main)](https://travis-ci.com/AXIM0S/gearlock)

GearLock is a dynamically written bash program focused in performance with the intension of making modifications in android-x86 easier.

It is also intended to replace the need for traditional custom-recovery software for android-x86 which are found in mobile phones.

GearLock was made in a different perspective unlike traditional custom-recovery software for mobile phones.

GearLock and everything within it are standalone programs and does not need to rely on the android system.

It can be used both GUI and TTY in a user-friendly manner, including advanced CLI usage.



# Features

I mainly post updates at https://supreme-gamers.com/r/gearlock-custom-recovery-replacement-for-android-x86.40

So, check there.

This repo is only used for development and issue tracking.



# Pre-baked GearLock

GearLock is being proudly integrated with the following reputed distros:

* BlissOS-x86
* PhoenixOS DarkMatter

If you're working on a remarkable distro and want to bring GearLock into it then you're welcome :)



# Development and Contributing

Feel free to create a fork and help make this project even better.

If you want to build GearLock then all you gotta do is running the following command:

```bash
git clone https://github.com/AXIM0S/gearlock && cd gearlock && chmod +x makeme && ./makeme
```

Then you should find the outputs at `out/build_installer_out`

For working over sources for the core files, take a look at `core/` and `core/_external_bin/`

You might have noticed that there are prebuilt binaries in the repository but not their source code.

I would need to setup a complete build system for them, what I've been doing was hand-compiling them.

I will need a lot of free time to accomplish this since I'm a student, but you can surely expect this in the future.



# Additional Links

* GearLock dev-doc: https://supreme-gamers.com/gearlock
* GearLock dev-kit: https://github.com/AXIM0S/gearlock-dev-kit
* GearLock core-pkg: https://github.com/AXIM0S/gearlock-core-pkg
* GearLock mesa-pkg: https://github.com/AXIM0S/gearlock-core-pkg
* GearLock kernel-pkg: https://github.com/AXIM0S/gearlock-kernel-pkg



# GearLock integration with Android-x86 source

Currently patches are only available for nougat, oreo, pie and q.
Although other versions are supported by the `executable-gearlock-installer`.
Patch files for murshmellow and lolipop will be included later on.

Adaptation for Android-Generic Project and improvements by: @electrikjesus

* First clone the repo into `vendor/` from your aosp project root.

> ```bash
> git clone https://gitlab.com/AXIM0S/vendor-gearlock vendor/gearlock
> ```

* Now apply the patches:

> ```bash
> . build/envsetup.sh
> apply-gearlock-patches
> ```

* Then build ISO.

> Android-Generic (x86/PC):
`build-x86 android_x86_64-userdebug`

> BlissOS 11.x:
`build-x86.sh android_x86_64-userdebug`

> Android-x86:
`lunch android_x86_64-userdebug && make iso_img`



# Credits and thanks

Here I'm trying to list all of the remarkable work by others which has been used to enrich GearLock.

Without their open-minded years of hard work, GearLock wouldn't have been the same.

* The great legendary GNU communtiy for their free and opensource softwares.
> https://www.gnu.org/software
* Igor Pavlov (p7zip)
> http://p7zip.sourceforge.net
* mcmilk (p7zip zstd plugin)
> https://github.com/mcmilk/7-Zip-zstd
* Jack Palevich (Terminal Emulator)
> https://github.com/jackpal/Android-Terminal-Emulator
* Roumen Petrov (Better Terminal Emulator, Termoneplus)
> https://gitlab.com/termapps/termoneplus

## Also thanks to

* @hmtheboy154 (Contibutor)
* @SGNight (Contibutor)
* @electrikjesus (Contributor)
* Mido Fayad (Contibutor & Donator)
* Ahmad Moemen (Contibutor)
* Diaz (Donator)
* rk (Donator)
* https://github.com/opsengine/cpulimit
* https://github.com/landley/toybox
* https://github.com/osospeed/ttyecho
* http://e2fsprogs.sourceforge.net



# Copyright and License

```
    GearLock
    Copyright (C) 2021  SupremeGamers

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; version 2.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
```
