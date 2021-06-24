# Introduction  [![GearLock](https://img.shields.io/badge/GearLock-7.2.40-blue.svg)](https://github.com/AXIM0S/gearlock) [![CI](https://github.com/AXIM0S/gearlock/workflows/CI/badge.svg)](https://github.com/AXIM0S/gearlock/actions) [![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org) [![](https://tokei.rs/b1/github/axonasif/gearlock?category=lines)](https://github.com/axonasif/gearlock)

GearLock is a dynamically written bash program focused in performance with the intension of making modifications in android-x86 easier.

It is also intended to replace the need for traditional custom-recovery software for android-x86 which are found in mobile phones.

GearLock was made in a different perspective unlike traditional custom-recovery software for mobile phones.

GearLock and everything within it are standalone programs and does not need to rely on the android system.

It can be used both GUI and TTY in a user-friendly manner, including advanced CLI usage.



# Features

<details>
  <summary>Spoiler (click here)</summary>
  
- Install any custom kernel / mesa or pretty much anything. There are also tons of other extension & packages available in our RESOURCES section for you to install with a powerful package-manager.

- Install flashable zip files. (BETA)

- Use RECOVERY-MODE even before your android starts.
- + MidNight Commander FileManager integration in recovery mode.
- + Repair corrupted EXT partitions before booting up the OS.

- Decompress / extend the size of your system image

- Backup & restore your whole data

- Mesa Version faker

- Change CPU governor & frequency

- Change MAC Address

- Update google apps directly from a opengapps package

- Install latest/custom magisk version directly from github source by patching the ramdisk. (on-device)

- GoogleLess Mode feature

- Unity Game Engine Crash Fix

- Resolve the issue for magisk installation, in which magisk makes the tty unusable

- SU-Handler for switching between SuperSU & MagiskSU

- Introducing GearProp, which can force overwrite any system property.

- Purge / remove extra kernel modules from your system

- MultiLang support with UTF8. (EN, VN, {CN, ES --- yet to be done})

- Record screen with audio without any app. (Directly from gearlock with internal audio support)

- Very developer friendly with tons of easy to use tools

- Disable / Enable Laptop touchpad or keyboard

- Extensible by installing custom extensions

- And many more! This list is probably outdated, lol.
  
</details>


# Boot flags


You can control the behavior of GearLock early recovery screen with boot-flags.
There are three kinds of flags you can use.

<details>
  <summary>Spoiler (more details)</summary>


- NORECOVERY
- ALWAYSRECOVERY
- FIXFS
- NOGFX

## NORECOVERY

This helps you bypass the recovery countdown screen. You can either put `NORECOVERY=1` in your grub-config or make a file named norecovery in your android-x86 partition.

### Grub config example:

```bash
linux /kernel quiet NORECOVERY=1
```

## ALWAYSRECOVERY​

This lets you to auto-enter recovery mode always* without having to press ESC.
Just like NORECOVERY, you can active this by grub (`ALWAYSRECOVERY=1`) or by making a file named `alwaysrecovery` in android-x86 partition.

## FIXFS

This will auto-fix extFS on each boot from the option which you find in recovery mode.

In other words, it will run fsck against your root partition.

Grub-Flag> `FIXFS=1`

File-Flag> `fixfs`


## NOGFX

When this flag is found, GearLock does not attempt to get the best possible visuals during RECOVERY-MODE. There are some really rare cases among some users in which when GearLock tries to ensure better visuals, kernel panic happens during boot.

Grub-Flag> `NOGFX=1`
File-Flag> `nogfx`

</details>



# Flashable ZIP Compatibility

If you want my honest word then you should know that about 99% of the available flashable zips out there will likely fail since they were never made for android-x86 and GearLock has nothing to do about that. In which most of them are flashable-roms which you obviously won't be installing on android-x86. Currently I've had success with OpenGapps and a few other zips. Other than that will surely fail unless the developer itself implements android-x86 support.



# Pre-baked GearLock

GearLock is being proudly integrated with the following reputed distros:

* BlissOS-x86
* PhoenixOS DarkMatter

If you're working on a remarkable distro and want to bring GearLock into it then you're welcome :)



# Development and Contributing

Feel free to create a fork and help make this project even better.

Your commits should follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0) specification, otherwise they will be rejected.

If you want to build GearLock then all you gotta do is run the following command:

* From linux distros

> ```bash
> git clone https://github.com/axonasif/gearlock && cd gearlock && bash makeme
> ```

* From android-x86 distros (assuming you have GearLock installed)

> ```bash
> curl -L https://git.io/JO43W -o gearlock.zip
> unzip -qq gearlock.zip && cd gearlock-main && bash makeme
> ```

Then you should find the outputs at `out/installer`

If you want to test bare basic functionalities of GearLock within a linux-distro for development porposes then run:

```bash
bash makeme --setup-devenv "$HOME/gdev"
```

For working over sources for the core files, take a look at `core/` and `core/_external_bin/`

Also check `core/_lang_/` if you want to improve the language translations and concurrent strings.

You might have noticed that there are prebuilt binaries in the repository but not their source code.

I would need to setup a complete build system for them, what I've been doing was hand-compiling them.

I will need a lot of free time to accomplish this since I'm a student, but you can surely expect this in the future.



# Additional Links

* GearLock dev-kit: https://github.com/AXIM0S/gearlock-dev-kit
* GearLock core-pkg: https://github.com/AXIM0S/gearlock-core-pkg
* GearLock mesa-pkg: https://github.com/AXIM0S/gearlock-mesa-pkg
* GearLock kernel-pkg: https://github.com/AXIM0S/gearlock-kernel-pkg
* GearLock dev-doc: https://wiki.supreme-gamers.com/gearlock/developer-guide



# Integration with Android-x86 source

Adaptation for Android-Generic Project was done by: @electrikjesus

### Clone the repo into `vendor/` from your aosp project root.

> ```bash
> git clone https://github.com/AXIM0S/gearlock vendor/gearlock
> ```

### Lastly, build ISO

> Android-Generic (x86/PC):
`build-x86 android_x86_64-userdebug`

> BlissOS 11.x:
`build-x86.sh android_x86_64-userdebug`

> Android-x86:
`lunch android_x86_64-userdebug && make -j4 iso_img`



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
* https://github.com/termux/termux-packages
* https://github.com/opsengine/cpulimit
* https://github.com/landley/toybox
* https://github.com/osospeed/ttyecho
* http://e2fsprogs.sourceforge.net
* https://github.com/arter97/resetprop



# Copyright and License

This project is [GPL-2.0](https://github.com/AXIM0S/gearlock/blob/main/LICENSE) licensed.

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
