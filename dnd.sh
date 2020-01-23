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
status=$(defaults -currentHost read ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb)

if [[ $opt == "status" ]]; then
  echo $status
elif [[ $opt == "on" ]]; then
  defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean true
  defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date "`date -u +\"%Y-%m-%d %H:%M:%S +000\"`"
  # echo "Do Not Disturb is enabled. (OS X will turn it off automatically tomorrow)."
  killall NotificationCenter
elif [[  $opt == "off" ]]; then
  defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean false
  # echo "Do Not Disturb is disabled."
  killall NotificationCenter
fi
