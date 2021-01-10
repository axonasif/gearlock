BUILD_TOP := $(shell pwd)

GEARLOCK_ROOT:= "$(call my-dir)"
include $(call all-subdir-makefiles)
