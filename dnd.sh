#!/usr/bin/env bash

# Set global variables
PROGNAME=$(basename "$0")
VERSION='1.0.0'

print_help() {
cat <<EOF
Usage:    $PROGNAME [options]
Version:  $VERSION

DND: Do Not Disturb
Control macOS notification "Do Not Disturb" settings

Options:
  status     Current Do Not Disturb status
               0: Disabled
               1: Enabled
  on         Enable Do Not Disturb
  off        Disable Do Not Disturb

Example:
  dnd on

EOF
exit $1
}

while getopts "h" opt; do
  case $opt in
    h) print_help 0;;
    *) print_help 1;;
  esac
done

shift $(( OPTIND - 1 ))

opt=${1:-on}
osascript <<EOD
  set opt to "$opt"
  tell application "System Events" to tell application process "SystemUIServer"
    try
      set dnd_status to (exists menu bar item "Notification Center, Do Not Disturb enabled" of menu bar 1)
      if opt is "status" then
        set output to dnd_status as integer
      else if {"on", "off"} contains opt then
        key down option
        if   (opt is "off" and dnd_status is true ) ¬
          or (opt is "on"  and dnd_status is false) then
          # name of menu bar item 1 of menu bar 1 starts with "Notification Center"
          click (the first menu bar item of menu bar 1 whose name starts with "Notification Center")
        end if
        key up option
      end if
    on error
      key up option
    end try
  end tell
EOD
