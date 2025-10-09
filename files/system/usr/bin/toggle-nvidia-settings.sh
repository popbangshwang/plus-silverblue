#!/usr/bin/env bash

SOURCE_DESKTOP="/usr/local/share/applications/nvidia-settings.desktop"
OVERRIDE_DESKTOP="/etc/xdg/autostart/nvidia-settings.desktop"

if [ ! -f "$SOURCE_DESKTOP" ]; then
  echo "Source .desktop file missing."
  exit 1
fi

# Copy the base .desktop file to override path
cp "$SOURCE_DESKTOP" "$OVERRIDE_DESKTOP"

if lspci | grep -qi nvidia; then
  # Show NVIDIA Settings
  sed -i 's/^NoDisplay=true/NoDisplay=false/' "$OVERRIDE_DESKTOP"
  echo "NVIDIA GPU detected, un-hiding NVIDIA Settings."
else
  # Hide it
  sed -i 's/^NoDisplay=false/NoDisplay=true/' "$OVERRIDE_DESKTOP"
  echo "No NVIDIA GPU detected, hiding NVIDIA Settings."
fi
