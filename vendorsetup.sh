# Hook makeme on source trigger
makefile="$(pwd)/vendor/gearlock/makeme"
chmod +x "$makefile" || { echo -e 'Error: Failed to make gearlock makefile executable' && exit 1; }
#"$makefile" --aosp-project-vendorsetup "$(pwd)"

# Save the official lunch command to aosp_lunch() and source it
tmp_lunch="$(mktemp)"
sed '/ lunch()/,/^}/!d'  build/envsetup.sh | sed 's/function lunch/function aosp_lunch/' > "${tmp_lunch}"
source "${tmp_lunch}"
rm -f "${tmp_lunch}"

# Override lunch function to filter lunch targets
function lunch
{
    local T="$(gettop)"
    if [ ! "$T" ]; then
        echo "[lunch] Couldn't locate the top of the tree.  Try setting TOP." >&2
        return 1
    fi

    aosp_lunch $*

    "$makefile" --aosp-project-makefile 
    cd "$(pwd)"
}
