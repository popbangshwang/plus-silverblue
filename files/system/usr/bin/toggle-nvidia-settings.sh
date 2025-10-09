#!/usr/bin/env bash

DESKTOP_FILE="/usr/share/applications/nvidia-settings.desktop"

# Only proceed if the file exists
if [ -f "$DESKTOP_FILE" ]; then
  if lspci | grep -qi nvidia; then
    # NVIDIA GPU found - show the app
    sed -i 's/^NoDisplay=true/NoDisplay=false/' "$DESKTOP_FILE"
    echo "NVIDIA GPU detected, un-hiding NVIDIA Settings."
  else
    # No NVIDIA GPU - ensure it's hidden
    sed -i 's/^NoDisplay=false/NoDisplay=true/' "$DESKTOP_FILE"
    echo "No NVIDIA GPU detected, hiding NVIDIA Settings."
  fi
fi
