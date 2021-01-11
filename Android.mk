GEARLOCK_ROOT:= "$(call my-dir)"

gearlock: 
	@$(GEARLOCK_ROOT)/makeme --aosp

all: 
	$(gearlock)
