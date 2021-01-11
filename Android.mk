GEARLOCK_ROOT:= "$(call my-dir)"

gearlock: 
	@chmod +x $(GEARLOCK_ROOT)/makeme
	@$(GEARLOCK_ROOT)/makeme --aosp-project-makefile
