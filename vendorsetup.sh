# Hook makeme on source trigger
makefile="$(pwd)/vendor/gearlock/makeme"
chmod +x "$makefile" || { echo -e 'Error: Failed to make gearlock makefile executable' && exit 1; }
"$makefile" --aosp-project-vendorsetup "$(pwd)"
