#!/usr/bin/env bash

OPCION=$(echo -e "Power Off\nReboot\nSuspend" | fuzzel --dmenu --prompt="argentOs menu")

case "$OPCION" in
    "Power Off") systemctl poweroff ;;
    "Reboot")    systemctl reboot ;;
    "Suspend")   systemctl suspend ;;
esac
